## Example usage

```yaml
- name: socks ssh action
  uses: Ayouuuu/ssh-socks-action
  with:
    proxy_username: ${{ secrets.USER_NAME }}
    proxy_server: ${{ secrets.SERVER }}
    proxy_port: ${{ secrets.PORT }}
    proxy_socks5_pwd: ${{ secrets.SOCKS5_PWD }}
    host: 114.112.113.221
    port: 32200
    username: 'root'
    key: ${{ secrets.KEY }}
    run: |
      ls
      whoami
```
