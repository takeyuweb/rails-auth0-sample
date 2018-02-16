import Auth0Lock from 'auth0-lock';

document.addEventListener('DOMContentLoaded', () => {
  const element = document.getElementById('js-auth0-lock');
  if (element) {
    const dataset = element.dataset;
    const lock = new Auth0Lock(dataset.auth0ClientId, dataset.auth0Domain);

    const loginButton = document.getElementById('js-login-button');

    // ログインモーダルを表示
    // カスタマイズする方法はドキュメント参照 https://auth0.com/docs/libraries/lock/v11
    // divへの埋め込み、スマホ向けのパスワードなしなどいろいろできる
    loginButton.addEventListener('click', () => {
      lock.show();
    });

    lock.on('authenticated', (authResult) => {
      lock.getUserInfo(authResult.accessToken, (error, profile) => {
        if (error) {
          alert(error);
          return;
        }

        loginButton.style.display = 'none';
        document.getElementById('js-nickname-area').textContent = profile.nickname;
        console.log(profile);
      });
    });
  }
});
