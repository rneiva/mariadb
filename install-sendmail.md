This should help you get Sendmail installed with basic configuration on Ubuntu.

If sendmail isn't installed, install it: sudo apt-get install sendmail

- Configure /etc/hosts file: nano /etc/hosts
- Make sure the line looks like this: 127.0.0.1 localhost yourhostname
- Run Sendmail's config and answer 'Y' to everything: sudo sendmailconfig
- Restart apache sudo service apache2 restart
