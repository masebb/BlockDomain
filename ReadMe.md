## やりたかったこと
集中したいときにコンテナを立ち上げて、非生産的コンテンツ(Twitter、Youtubeなど)をDNSブロック(適当な応答を返す)したかった。
## 動かし方
```shell
~ $ git clone https://github.com/masebb/BlockDomain.git
~ $ cd BlockDomain/
#お好みのエディタでblockdomains.confを編集します(カンマ区切りでドメイン名を記述)
~ $ sudo docker build -t easy-snsblocker ./
~ $ sudo docker-compose up -d
```
最後にブロックさせたい端末のDNS設定で優先DNSサーバーとしてこのコンテナが立ち上がってるパソコンのIPアドレスを設定する
## 問題点
 - **このコンテナによる応答結果がキャッシュされてしまってコンテナを終了させても一定時間登録したドメインのアクセスができなくなる**
   - 一定時間だけ遮断 などのことができない
   - キャッシュを消すには各種OSに合ったコマンドを実行する必要
     - モバイル端末はキャッシュを消すのに再起動が必要など、現実的ではない
     - OSにあるキャッシュを消してもブラウザなどのアプリケーション上ででキャッシュされていたりするので完全なキャッシュの削除が困難
 - `./internal/rpz.zone`のシリアル番号をビルド時に増加させていない
 - `blockdomains.conf`の正当性チェックをしていない(`named-checkzone`で弾けてる...?)
 - `blockdomains.conf`にコメントを書けない
