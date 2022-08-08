#!/bin/bash

# AsciiDocファイルをビルドする。

# ビルド対象のAsciiDocファイル
target_files[0]=docker_setup.adoc
target_files[1]=jenkins_setup.adoc
target_files[2]=gitea_setup.adoc
# ビルド後のファイルを格納するディレクトリ
readonly destination=build/
# 変換後のAsciiDocファイルに情報を埋め込む対象のコミット
readonly target_commit=HEAD
# コミットID
commit_hash=$(git rev-parse --short ${target_commit})
# コミット日時
commit_date=$(git log -1 --format='%cI' ${target_commit})

# ビルド対象の各ファイルに対して
for i in "${!target_files[@]}"
do
    # HTML形式に変換する。
    asciidoctor -r asciidoctor-diagram --trace --verbose "${target_files[$i]}" \
    -a commit-hash="${commit_hash}" -a commit-date="${commit_date}"
    # PDF形式に変換する。
    asciidoctor-pdf -r asciidoctor-diagram -r ./config.rb --trace --verbose "${target_files[$i]}" \
    -a commit-hash="${commit_hash}" -a commit-date="${commit_date}"
done

# ビルドした成果物を移動
mv ./*.html ./*.pdf "${destination}"
cp -r image/ "${destination}"
