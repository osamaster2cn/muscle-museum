/**
 * 設定されたファイルのURLを読み取り
 * プレビュー表示を実現する
 * @param id -- imgタグののid
 */

window.previewFileWithId = function(id) {
  // イベント発生源の取得
  const target = this.event.target;
  // イベントターゲットより、ファイルを取得
  const file = target.files[0];
  // ファイルを読み込むためのFileReaderオブジェクトを定義
  const reader  = new FileReader();
  // Fileオブジェクトが取得できた場合
  if (file) {
    // FileオブジェクトのURLを読み込んで設定する
    reader.readAsDataURL(file);
  } else {
    // 取得できなかった場合はURLに空を設定
    preview.src = '';
 }

 // ファイル読み込みが完了した時に発生
 reader.onloadend = function () {
  preview.src = reader.result;
  }

} 