# This should help you get Sendmail installed with basic configuration on Ubuntu.

<p align="center">
  <a href="https://ubuntu.com/" target="blank"><img src="https://149366088.v2.pressablecdn.com/wp-content/uploads/2020/04/ubuntu-focal-logo-Untitled-1.jpg" width="320" alt="Ubuntu Logo" /></a>
</p>


*If sendmail isn't installed, install it: sudo apt-get install sendmail

```
- Configure /etc/hosts file: nano /etc/hosts
- Make sure the line looks like this: 127.0.0.1 localhost yourhostname
- Run Sendmail's config and answer 'Y' to everything: sudo sendmailconfig
- Restart apache sudo service apache2 restart
```
