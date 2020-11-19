# Calendarアプリとは

このアプリは個人向け、及びチームを対象としたカレンダーアプリです。


# アプリケーションのURL

上記のURLからアプリ画面に遷移することができます。
少し起動時に時間がかかってしまうことがあります。

## Id/Pass

- ID: 
- Pass: 

# テスト用アカウント

## テストユーザー

## テストチーム

# 要件定義


## テーブル設計

![calendar](https://user-images.githubusercontent.com/71364105/99646298-a7e08380-2a93-11eb-8a03-be809e92cca1.png)

## ローカルでの動作方法

``` 
% ruby --version  を実行します。

バージョンが2.6.5であることを確認します。

% rails -v を実行します。

バージョンが6.0.0であることを確認します。

次に、ローカルにアプリケーションをクローンします。

% git clone https://github.com/tanaka-shoya-2020/query.git

アプリケーションのディレクトリに移動します。

% cd query

gemをインストールします。

% bundle install

yarnをインストールします。

% yarn install

データベースを作成します。

% rails db:create

マイグレーションに記述した内容を、データベースに適用します。

% rails db:migrate
```
