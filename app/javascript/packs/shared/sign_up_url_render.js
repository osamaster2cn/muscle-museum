window.onload = function () {
  let path = location.pathname;

  // URLを変更
  history.replaceState('', '', `${path}/sign_up`)
}
