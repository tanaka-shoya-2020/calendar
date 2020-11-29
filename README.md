# Calendarアプリとは

このアプリは個人、及びチームでの予定管理を目的としたカレンダーアプリです。


## アプリケーションのURL

http://calen-proto-2020.tk

上記のURLからアプリ画面に遷移することができます。
少し起動時に時間がかかってしまうことがあります。

## テスト用アカウント

### ユーザー用
|　メールアドレス　　　 |　パスワード　|
|-------------------|------------|
| foobar1@gmail.com | foobar1　　 |

### チーム用
|　チーム名　　　      |　パスワード　|
|-------------------|------------|
| テストチーム        | foobar1　　 |

## 要件定義

|            機能                           |            目的                                                   |
|----------------------------------------- |------------------------------------------------------------------|
|トップページの作成                           |サービスを利用するユーザーが閲覧したときに、何をするアプリか明確にするため     |
|ユーザー管理機能の導入                       |ユーザーのログイン管理をするため                                        |
|チーム管理機能の導入                         |チームでのログインを入れることで、多人数でのスケジューリングを可能にするため    |
|カレンダー機能の導入                         |カレンダーを用いた予定管理を行うため                                      |
|投稿機能の導入                              |ユーザー自分のカレンダーの予定を管理するため                               |
|編集機能の導入                              |ユーザーがカレンダーの投稿内容を編集するため                               |
|削除機能の導入                              |投稿したカレンダーの内容を削除するため                                    |
|HerokuからAWSのEC2へデータの移行             |アプリケーションの管理をより細かくカスタマイズするため                      |
|Googleアカウントでのログイン機能の追加         | ユーザーにとってより使いやすいサービスにするため                          |



## テーブル設計

![calendar ](https://user-images.githubusercontent.com/71364105/100534730-68652480-3255-11eb-9fb6-c36e32e7587d.png)

## インフラ設計図


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
