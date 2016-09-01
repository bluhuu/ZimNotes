# SSH-KeyGen 的用法

假设 A 为客户机器，B为目标机；

要达到的目的：<br>
A机器ssh登录B机器无需输入密码；<br>
加密方式选 rsa|dsa均可以，默认dsa

做法：<br>
1、登录A机器<br>
2、ssh-keygen -t [rsa|dsa]，将会生成密钥文件和私钥文件 id_rsa,id_rsa.pub或id_dsa,id_dsa.pub<br>
3、将 .pub 文件复制到B机器的 .ssh 目录， 并 cat id_dsa.pub >> ~/.ssh/authorized_keys<br>
4、大功告成，从A机器登录B机器的目标账户，不再需要密码了；

ssh-keygen做密码验证可以使在向对方机器上ssh ,scp不用使用密码.<br>
具体方法如下:<br>
ssh-keygen -t rsa<br>
然后全部回车,采用默认值.

这样生成了一对密钥，存放在用户目录的~/.ssh下。<br>
将公钥考到对方机器的用户目录下，并拷到~/.ssh/authorized_keys中。

要保证.ssh和authorized_keys都只有用户自己有写权限。否则验证无效。（今天就是遇到这个问题，找了好久问题所在），其实仔细想想，这样做是为了不会出现系统漏洞。
