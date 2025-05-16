# Stapler-mini
<p align="center">
 <img src=https://github.com/user-attachments/assets/cc5e0b43-4d6c-4f2c-a7ef-8930f7dcfbb5>
</p>

Stapler-miniは[Karabiner-Elements](https://karabiner-elements.pqrs.org/)で使える設定ファイルを出力するjson出力アプリです。
Karabiner-Elementsで認識できるキーボードならどんなキーボードでも、リマップ・タップホールド・レイヤー機能・コンボを直感的にカスタマイズすることができます。

## ダウンロード

### Karabiner-Elementsをダウンロード
[Karabiner-Elements](https://karabiner-elements.pqrs.org/)をダウンロードしていない場合はダウンロード、案内の通りに権限を与えます。

### Stapler-miniをダウンロード
<p align="center">
 <img src=https://github.com/user-attachments/assets/2e2ba43a-ff35-4ce6-8745-6be44c22c911>
 <img src=https://github.com/user-attachments/assets/1be0b596-032c-4c73-bb4d-1d816bae1eb4>
</p>

ダウンロードした後zipファイルを解凍し開こうとすると以下のような警告が出ます()
<p align="center">
<img src="https://github.com/user-attachments/assets/d05c3c0a-19b8-444d-9dd3-ed258665a089" />
</p>
**？** をクリックするとヘルプウインドウが立ち上がるのでアプリを開きたい場合は指示に従ってください。
<p align="center">
 <img align="center" width="1073" alt="ss 2025-05-16 15 10 47" src="https://github.com/user-attachments/assets/5f063989-f68b-4c76-9ef0-80b4e7904b89" />
 <img align="center" width="711" alt="ss 2025-05-16 15 11 32" src="https://github.com/user-attachments/assets/8515dae5-ab90-4db1-8ea8-fc628f8390f6" />
</p>

## カスタマイズの流れ

### Configurationの作成
<p align="center">
 <img width="1552" alt="ss 2025-04-16 19 02 26" src="https://github.com/user-attachments/assets/ea584596-8969-4983-bc1d-4b5a1c05a55c" />
</p>

左上の＋ボタンを押すとシートが表示されます。カスタマイズしたいキーボードの配列やサイズを合わせてからAdd Configurationをクリックします。（ちょっと重いかも…Sorry…）

### デバイスの編集
<p align="center">
 <img width="1552" alt="image" src="https://github.com/user-attachments/assets/baefacf0-a085-4d13-a40b-3788eaf6a557" />
</p>

DeviceEditタブで元々のキーボードのIDや、元々のキーコードを変更することが可能です。デバイス右上の歯車ボタンをクリックするとデバイスに対してポップオーバーが表示されます。ここでデバイスごとにIDの編集や有効化無効化が行えます。

キーコードの編集は下に表示されているキーをドラッグ&ドロップか、クリックで選択されているキーボードキーに対して変更を加えることができます。もしくはキーボードキーをダブルクリックすることで入力監視モードに移ります。インジケーターが点滅している間に入力されたキーコードを注入することができます。

Stapler-miniでは3つのデバイスを一度にカスタマイズすることができます。大きな＋ボタンをクリックするとデバイスが有効になります。デバイス左上のーボタンをクリックすると無効にできます。例えば、レイヤー1のマウスの左クリックに好きなコマンドを割り当てたりできます。

### キーボードをリマップする
<p align="center">
 <img width="655" alt="ss 2025-04-16 19 09 09" src="https://github.com/user-attachments/assets/2ef092d0-2cb5-442f-8b82-b156646f9de0" />
</p>

Remapタブではキーの配置などを好きにカスタマイズすることができます。下のキーをキーボードキーにドラッグ&ドロップ、選択されているキーボードキーにキーをクリックで注入、長押しでホールドに注入、キーボードキーをダブルクリックで入力監視状態に移行しキーボードの入力で注入してカスタマイズすることが可能です。

また、さまざまな条件に基づいてカスタムを分岐することが可能です。
<p align="center">
 <img width="818" alt="image" src="https://github.com/user-attachments/assets/9fddeeb9-9e5d-46fd-b2eb-160b545f9041" />
</p>

#### レイヤー

ホームポジションのみで数字やArrowキーを入力できるようになったり、アプリ用のレイヤーからよく使うようなコマンドをホームポジションの打ちやすいキーで発火できるようになるのが強みです。
自作キーボードの機能を再現した機能で、Karabiner-Elementsで変数の状態を用いて書き換えを行うかどうかを分岐することで再現しています。

Baseが普通にキーを押下した状態で、その他が数字・色に応じたレイヤーです。
平行四辺形のボタンでレイヤーを切り替えてカスタマイズできます。レイヤーへの遷移はモーメンタリー、トグルキーがあるのでそれを任意のキーに割り当ててください。
おすすめはスペースキーの長押しにレイヤーモーメンタリーを割り当てすることです。親指で押しながら他の指でレイヤーのキーコードを発火できます。

#### アプリ、トラックパッドに触れている指の本数、IMEの状態
Conditionをピッカーから変更して9個分のConditionを追加でカスタマイズすることができます。それぞれに対して条件に必要なテキストフィールドを埋めることでその条件下のみで書き換えが行われるようになります。

#### タップホールドのカスタマイズ
<p align="center">
 <img width="480" alt="image" src="https://github.com/user-attachments/assets/cdd73473-9053-4b2d-843e-e82f78004c12" />
</p>

ポップオーバーかサイドバーからタップホールドを有効にすることができます。
タップホールドとはタップとホールドで違うキーコードを割り当てることができる機能です。例えばTabキーはタップしか通常使いませんが、そのホールドを好きな修飾キーやレイヤー遷移キーにすることができるようになります。

タップホールドが有効になっているが片方しかカスタマイズされていない場合、出力時にはもう片方にも同じカスタマイズが入ります。

##### Chord
タップとホールドというよりは他のキーと押しているかどうかでタップとホールドどちらのキーコードを出力するかを決めるタイプです。他のキーと押せばホールド、そのキーのみの場合はタップのキーコードが出力されます。仕組み上ホールドに修飾キーとレイヤー遷移キー以外を入れると誤入力が発生します。

##### Duration
閾値を境にタップとホールドのキーコードを分岐するタイプです。
サイドバーからThresholdを設定すれば一つ一つの閾値を変更することも可能ですし、全体で揃えて閾値を変更したい場合はKarabiner-Elements側で設定することができます。

### コンボのカスタマイズ
<p align="center">
 <img width="481" alt="image" src="https://github.com/user-attachments/assets/e9c6bc6d-0635-426d-b63e-bcece08e6cfa" />
</p>

Comboタブではコンボをカスタマイズすることができます。

コンボとはキー複数の同時押しに対して好きなキーを割り当てることができる機能です。

＋ボタンを押してコンボを追加し、選択状態にした上でキーボードキーをクリックするとコンボの構成要素として登録されます。ハイライトされているキーボードキーの同時押しで割り当てたキー入力を発火できるような設定が出力できます。またRemapと同じようにレイヤーや、Condition、タップホールドのカスタマイズが可能です。

### マクロのカスタマイズ
<p align="center">
 <img width="418" alt="image" src="https://github.com/user-attachments/assets/0c9060bf-1afa-43ff-a098-1667f6824b67" />
</p>

MacroタブではRemap、Comboタブで割り当てできるマクロを定義することができます。
ここでのマクロとはキーコードの配列を指します。例えば⌘⇧left_arrow → ⌘X のようなマクロを作れば「文頭までのテキストを選択、カット」を一つのキーを押しただけで発火することが可能になります。

### 設定を出力する
⚠️実際に出力する前にはKarabiner-Elements側で新しくProfileを作っておくことを推奨⚠️
<p align="center">
 <img width="1552" alt="ss 2025-04-16 19 27 46" src="https://github.com/user-attachments/assets/6dee86a8-4ff5-4e74-b270-6538f52a9af8" />
</p>

右上のツールバーから出力ボタンを押すとシートが表示されます。

キーコードのリージョンはKarabiner-Elements側のVirtual Keyboard Typeに合わせてください。

Export to Karabiner-Elementsと進むとjsonファイルを保存する先を指定する画面になります。テキトーな場所に保存すると、そのファイルをKarabiner-Elements側でインポートする画面が開きます。

Importと進みKarabiner-Elements側Complex ModificationsタブでAdd Predifined Rulesからインポートした設定をEnable Allとすればカスタムした内容にキーボードが書き換えされるようになるはずです。

テキトーな場所に出力したjsonファイルは削除してしまって問題ありません。

### 実際に打てるかテストする
<p align="center">
 <img width="316" alt="ss 2025-04-16 19 33 52" src="https://github.com/user-attachments/assets/893fa274-3fe7-420d-b38a-8d3e8742a0fd" />
</p>

Karabiner-EventViewerから変数の状態や、出力されているキーコードを確認しましょう。
カスタム通りに打てていれば問題ありません。存分にキーボードカスタマイズを楽しんでください！

問題がある場合は[Discordサーバー](https://discord.gg/2v3FbTmd9c)にてお気軽に質問と罵倒をどうぞ！😇


## 細かいところの使い方

### Configurationの作成
<p align="center">
 <img width="496" alt="image" src="https://github.com/user-attachments/assets/f8c3c33b-09fd-443c-9c0b-f36337104001" />
</p>

Configurationには3つのデバイス、デバイスに含まれるキーボードキー、Macroの情報が含まれています。
左上の＋ボタンを押すとシートが表示され、カスタムしたいキーボードに近いものを選びAdd Configurationとして設定を追加してください。

右上のImport Configurationボタンを押すとjsonファイルをインポートしてConfigurationを追加できます。
⚠️注意：jsonと言ってもKarabiner-ElementsようのjsonではなくエクスポートからShareボタンで出力できるjsonファイルのみがインポートできます⚠️

### Macro
<p align="center">
 <img width="429" alt="ss 2025-04-17 10 43 08" src="https://github.com/user-attachments/assets/584b6626-3e57-4ccf-9b27-91c2f8b52996" />
</p>

MacroタブでUser Macroを新たに作成できます。
<p align="center">
 <img width="695" alt="ss 2025-04-17 10 44 19" src="https://github.com/user-attachments/assets/8c11d506-19d8-4d41-9c08-ed551dfd9858" />
</p>

一つのキーコードごとに修飾キーを割り当てることができます。画像のマクロを割り当てた場合、 **Hello!** と1つのキーの押下やコンボで打てるようになります。
<p align="center">
 <img width="692" alt="ss 2025-04-17 10 47 38" src="https://github.com/user-attachments/assets/e5afc5ae-03e5-45a1-a4a2-5cf074a117b6" />
</p>

作成したマクロを他のConfigurationでも使いたい場合は、左サイドバーのラベルへドラッグ&ドロップするとコピーできます。

### DeviceEdit
Device Editタブでは書き換える元のキーボードについての編集を行うことができます。

Karabiner-ElementsのSimple Modificationでキーコードを書き換えている場合は、そのキーコードに合わせた設定を作ると直感的にカスタマイズを行うことができます。


#### キーコードの編集
<p align="center">
 <img width="803" alt="ss 2025-04-17 11 04 26" src="https://github.com/user-attachments/assets/315e6292-0c5b-4273-abcf-4cf1cf2c8a7f" />
</p>

下のキーをドラッグ&ドロップするか、クリックして選択状態のキーボードキーに対してキーコードを注入することができます。
<p align="center">
 <img width="115" alt="ss 2025-04-17 11 08 46" src="https://github.com/user-attachments/assets/3447f4fd-6c33-42af-a027-a4fc44f4a230" />
</p>

またはキーボードキーをダブルクリックすると赤いインジケーターが点滅し、その状態で実際のキーボードからキー入力をするとそのキーコードを注入することができます。注入後は隣のキーボードキーに入力監視状態が移るので連続してキーコード編集を行えます。

#### キーボードキーの編集
<p align="center">
 <img width="274" alt="ss 2025-04-17 11 11 45" src="https://github.com/user-attachments/assets/847b4c91-c196-45ff-85fd-67a9dd96560e" />
</p>

選択状態のキーボードキーにカーソルをホバーするとポップオーバーが表示されます。
ここではキーの水平方向の大きさ、スペーサーか否か、キーのシェイプを選択できます。
is SpacerをトグルするとRemap,Comboタブでは表示されずスペーサー扱いになり、json出力時にもカスタムは無視されます。
<p align="center">
 <img width="270" alt="ss 2025-04-17 11 16 25" src="https://github.com/user-attachments/assets/4de98d1f-883a-4633-a702-312c5c777084" />
</p>

インスペクター(右サイドバー)をトグルするとさらに細かい情報をカスタマイズできます。
Labelでは表示されるテキストかSF Symbol名を入力して表示をカスタムできます。

#### デバイスの編集
<p align="center">
 <img width="1022" alt="ss 2025-04-17 11 14 42" src="https://github.com/user-attachments/assets/ba94ac60-0eea-4eb7-8ff9-ae048f5d0a4c" />
</p>

キーボードキーはデバイスに所属しています。デバイスに対してIDなどのConditionを追加してあげるとそのデバイスのそのキーコードのみを書き換えるようになります。
デバイス右上の歯車マークをクリックするとポップオーバーが表示され、各種IDの有効化とIDの編集が行えます。
スライダーを変更するとキーボードキーの単位サイズを変更できます。

### Remap
<p align="center">
 <img width="655" alt="ss 2025-04-16 19 09 09" src="https://github.com/user-attachments/assets/2ef092d0-2cb5-442f-8b82-b156646f9de0" />
</p>

Remapタブではキーの配置などを好きにカスタマイズすることができます。下のキーをキーボードキーにドラッグ&ドロップ、選択されているキーボードキーにキーをクリックで注入、長押しでホールドに注入、キーボードキーをダブルクリックで入力監視状態に移行しキーボードの入力で注入してカスタマイズすることが可能です。

また、さまざまな条件に基づいてカスタムを分岐することが可能です。
<p align="center">
 <img width="818" alt="image" src="https://github.com/user-attachments/assets/9fddeeb9-9e5d-46fd-b2eb-160b545f9041" />
</p>

#### レイヤー
自作キーボードの機能を模倣、再現した機能です。
Karabiner-Elementsで変数の状態を用いて書き換えを行うかどうかを分岐することで再現していて、ホームポジションのみで数字やArrowキーを入力できるようになったり、アプリ用のレイヤーからよく使うようなコマンドをホームポジションの打ちやすいキーで発火できるようになるのが強みです。

Baseが何もしていないレイヤーで、その他が数字・色に応じたレイヤーです。
平行四辺形のボタンでレイヤーを切り替えてカスタマイズできます。レイヤーへの遷移はモーメンタリー、トグルキーがあるのでそれを任意のキーに割り当ててください。
おすすめはスペースキーの長押しにレイヤーモーメンタリーを割り当てすることです。親指で押しながら他の指でレイヤーのキーコードを発火できます。

#### アプリ、トラックパッドに触れている指の本数、IMEの状態
Conditionをピッカーから変更して9個分のConditionを追加でカスタマイズすることができます。それぞれに対して条件に必要なテキストフィールドを埋めることでその条件下のみで書き換えが行われるようになります。

##### アプリ
<p align="center">
 <img width="781" alt="image" src="https://github.com/user-attachments/assets/c630cc7e-6408-425d-bd29-0c08279881db" />
</p>

Karabiner-EventViewerからConditionに使いたいアプリのバンドル識別子をコピーしテキストフィールドに貼り付けます。
##### Input Source
<p align="center">
 <img width="527" alt="image" src="https://github.com/user-attachments/assets/1f59f6e8-c648-4b79-9c7c-0bb231969304" />
</p>

Karabiner-EventViewerからConditionに使いたいlanguageを確認してそれをテキストフィールドに入力します。

##### トラックパッド

トラックパッドに触れている指の本数をテキストフィールドに入力するとその本数が触れている間だけ条件を満たすConditionになります。


#### タップホールドのカスタマイズ
<p align="center">
 <img width="244" alt="image" src="https://github.com/user-attachments/assets/110bb4d1-77ec-445f-be9a-5afb7bbbc227" />
</p>

タップホールドとはキーをタップした時とホールドした時で異なるキーコードを出力できるようになる機能です。
画像では元々がAのキーをタップしたときはB、ホールドして他のキーと押したときはLayer1に遷移する、というカスタマイズになります。
<p align="center">
 <img width="230" alt="image" src="https://github.com/user-attachments/assets/41d07510-6d27-4a1f-99d2-f9a1f711b5f6" />
</p>

右側のサイドバーからさらに細かいカスタマイズを行うことが可能です。
タップホールドにはChordとDurationという二つのタイプがあります。

##### Chord
タップとホールドというよりは他のキーと押しているかどうかでタップとホールドどちらのキーコードを出力するかを決めるタイプです。他のキーと押せばホールド、そのキーのみの場合はタップのキーコードが出力されます。仕組み上ホールドに修飾キーとレイヤー遷移キー以外を入れると誤入力が発生します。

**Lazy** をトグルするとホールドに修飾キーを入れた際、他のキーが押されるまでは修飾キーのキーコードが出力されず、他のキーが押された時のみ修飾キーを出力するようになります。

**Threshold** をトグルするとこのキーにのみ有効な閾値を設定できます。Chordタイプでは、``basic.to_if_alone_timeout_milliseconds``がスライダーでカスタムできます。

##### Duration
閾値を境にタップとホールドのキーコードを分岐するタイプです。
サイドバーからThresholdを設定すれば一つ一つの閾値を変更することも可能ですし、全体で揃えて閾値を変更したい場合はKarabiner-Elements側で設定することができます。

**Threshold** をトグルするとこのキーにのみ有効な閾値を設定できます。Durationタイプでは、``basic.to_if_held_down_threshold_milliseconds``がスライダーでカスタムできます。

##### マルチタップホールド
タップダンスのような機能です。・ー(トンツー)や、・・ー（トントンツー）などを好きなキーコードにカスタマイズできます（Karabiner-Elements15.3.9以降が必要）。

Chordタイプでは連打ホールドでタップに割り当てたキーコードをリピートできるようになるオプションを有効にできます。
これはタップにBackspaceなどを割り当ていて、連打ホールドでBackspaceのホールドが扱えるようになる、という使い方を想定しています。

##### Custom JSON
LayerとConditionを満たすキーボードキー1つ分の書き換えを出力し、編集することができます。出力されたテキストを他のコードエディタに貼り付けて作業することを推奨します。
複数の書き換えを内包しても構いませんが、注意としては **{** から始まって、 **}** で終わるようにしてください。

### Combo
<p align="center">
 <img width="573" alt="image" src="https://github.com/user-attachments/assets/12c1e7b8-24f3-4ead-92a7-e3236eb06b73" />
</p>

Comboタブではコンボをカスタマイズすることができます。

コンボとは複数のキーの同時押しに対して好きなキーを割り当てることができる機能です。

＋ボタンを押してコンボを追加し、選択状態にした上でキーボードキーをクリックするとコンボの構成要素として登録されます。
ハイライトされているキーボードキーの同時押しで割り当てたキー入力を発火できます。

またRemapと同じようにレイヤーや、Condition、タップホールドのカスタマイズが可能です。
画像はASDFの同時押しでレイヤー1にトグルされるようなカスタム例です。もしレイヤー1にComboを追加しASDFを割り当てた場合、レイヤー条件を満たしている時のみその書き換えが実行され、条件を満たしていない場合はレイヤー1のトグルが実行されるようなイメージです。

<p align="center">
 <img width="233" alt="ss 2025-04-17 12 26 50" src="https://github.com/user-attachments/assets/c90266b7-689e-4bf4-b0de-a00bf15a7ef4" />
</p>

#### Simultaneous Options

##### Threshold
コンボの閾値を設定できます。閾値ms以内に構成要素が同時に押された場合のみ書き換えが実行されます。

##### uninterrupt
コンボの構成要素以外が押された時でも、構成要素が全て同時に押されていればコンボの書き換えが実行されるようになるオプションです。

##### Down order
Simultaneousesの構成要素の順番と、実際にキーの押された順番で書き換えを実行するか否かを判定するオプションです。
###### Strict
 構成要素の正順通りに押された時のみ書き換えを実行するオプションです
###### Strict Inverse
 構成要素の逆順通りに押された時のみ書き換えを実行するオプションです
###### Insensitive
 押された順番は無視するオプションです。デフォルトはInsensitive。

##### Up Order
down orderのキーアップ版です。

##### Up When keys all up
コンボに割り当てたキーコードのキーアップをいつ発火するかを設定するオプションです。トグルするとコンボの構成要素全てのキーがkey_upした時にコンボに割り当てたキーコードのkey_upが出力されます。

##### Custom　JSON
LayerとConditionを満たすコンボ1つ分の書き換えを出力し、編集することができます。出力されたテキストを他のコードエディタに貼り付けて作業することを推奨します。
複数の書き換えを内包しても問題ありませんが注意としては **{** から始まって、 **}** で終わるようにしてください。

### Export
<p align="center">
 <img width="499" alt="image" src="https://github.com/user-attachments/assets/2545acb9-5583-4d8f-8423-922948654f6d" />
</p>

右上のツールバーから出力ボタンを押すとシートが表示されます。

キーコードのリージョンはKarabiner-Elements側のVirtual Keyboard Typeに合わせてください。
Export to Karabiner-Elementsと進むとjsonファイルを保存する先を指定する画面になります。テキトーな場所に保存すると、そのファイルをKarabiner-Elements側でインポートする画面が開きます。
Karabiner-Elements側でImportと進みComplex ModificationsタブでAdd Predifined Rulesからインポートした設定をEnable Allとすればカスタムした内容にキーボードが書き換えされるようになるはずです。
テキトーな場所に出力したjsonファイルは削除してしまって問題ありません。
Karabiner-Elementsでインポートした際ファイルは、

    ~/.config/karabiner/assets/complex_modifications

フォルダ内に複製されているので、手直ししたい際はそれをテキストディタで開いて編集してください。

シートからはShareボタンを押すとConfiguration自体を共有するためのjsonファイルが出力できます。

