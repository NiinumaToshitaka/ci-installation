#!/bin/sh

# AsciiDocファイルをビルドする。

# ビルド対象のAsciiDocファイル
target_file=docker_setup.adoc
# ビルド後のファイルを格納するディレクトリ
destination=build/

# HTML形式に変換する。
asciidoctor -r asciidoctor-diagram --trace --verbose "${target_file}"
# PDF形式に変換する。
asciidoctor-pdf -r asciidoctor-diagram -r ./config.rb --trace --verbose "${target_file}"

# ビルドした成果物を移動
mv *.html *.pdf "${destination}"
cp -r image/ "${destination}"
