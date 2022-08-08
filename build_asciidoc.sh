#!/bin/bash

# AsciiDocファイルをビルドする。

# ビルド対象のAsciiDocファイル
target_file=docker_setup.adoc
# ビルド後のファイルを格納するディレクトリ
destination=build/
# 変換後のAsciiDocファイルに情報を埋め込む対象のコミット
target_commit=HEAD
# コミットID
commit_hash=$(git rev-parse --short ${target_commit})
# コミット日時
commit_date=$(git log -1 --format='%cI' ${target_commit})

# HTML形式に変換する。
asciidoctor -r asciidoctor-diagram --trace --verbose "${target_file}" \
    -a commit-hash="${commit_hash}" -a commit-date="${commit_date}"
# PDF形式に変換する。
asciidoctor-pdf -r asciidoctor-diagram -r ./config.rb --trace --verbose "${target_file}" \
    -a commit-hash="${commit_hash}" -a commit-date="${commit_date}"

# ビルドした成果物を移動
mv ./*.html ./*.pdf "${destination}"
cp -r image/ "${destination}"
