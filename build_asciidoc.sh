#!/bin/bash

# AsciiDocファイルをビルドする。

# ビルド対象のAsciiDocファイル
target_file=top.adoc
# 出力ファイルの拡張子を除いたファイル名
output_basename="Docker+Jenkins+GiteaによるCI環境構築"
# ビルド後のファイルを格納するディレクトリ
readonly destination=build/
# 変換後のAsciiDocファイルに情報を埋め込む対象のコミット
readonly target_commit=HEAD
# コミットID
commit_hash=$(git rev-parse --short ${target_commit})
# コミット日時
commit_date=$(git log -1 --format='%cI' ${target_commit})

# ビルド対象の各ファイルに対して
# HTML形式に変換する。
asciidoctor -r asciidoctor-diagram --trace --verbose "${target_file}" \
-a commit-hash="${commit_hash}" -a commit-date="${commit_date}" -o ${output_basename}.html
# PDF形式に変換する。
asciidoctor-pdf -r asciidoctor-diagram -r ./config.rb --trace --verbose "${target_file}" \
-a commit-hash="${commit_hash}" -a commit-date="${commit_date}" -o ${output_basename}.pdf

# ビルドした成果物を移動
mv ./*.html ./*.pdf "${destination}"
cp -r image/ "${destination}"
