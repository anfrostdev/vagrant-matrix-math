#!/usr/bin/env bash

apt-get update
apt-get upgrade

apt-get install -y build-essential python3-pip git
pip3 install pytest
pip install tox

add-apt-repository -y ppa:deadsnakes/ppa
apt-get update
apt-get install -y python3.11 python3.11-dev python3.13 python3.13-dev

useradd -s /bin/bash -d /home/test/ -m -G sudo -p "$(python3 -c "import crypt; print(crypt.crypt(\"test\", \"\$6\$$(</dev/urandom tr -dc 'a-zA-Z0-9' | head -c 32)\$\"))")" test
echo -e "Match User test\n    PasswordAuthentication yes" | tee /etc/ssh/sshd_config.d/10-password-login-for-special-user.conf
systemctl restart ssh.service

cd /tmp
git clone https://github.com/anfrostdev/pyd-matrix-math.git
git clone https://github.com/anfrostdev/py-matrix-math-launcher.git

cd /tmp/pyd-matrix-math
python3 setup.py build
python3 setup.py install

sudo -u test cp /tmp/py-matrix-math-launcher/src/*.py /home/test
sudo -u test cp -r /tmp/py-matrix-math-launcher/tests/ /home/test
sudo -u test cp /tmp/py-matrix-math-launcher/examples/matrix1.txt /home/test
sudo -u test cp /tmp/py-matrix-math-launcher/examples/matrix2.txt /home/test
sudo -u test cp -r /tmp/pyd-matrix-math/ /home/test
rm -rf /tmp/pyd-matrix-math/
rm -rf /tmp/py-matrix-math-launcher/

sudo -u test tee /home/test/pytest.ini <<EOT
[pytest]
pythonpath = .
EOT
sudo -u test tee /home/test/tox.ini <<EOT
[tox]
envlist = py310, py311, py313
skipsdist = True

[testenv]
changedir = tests
deps = pytest
commands =
    python3 -m pip install -e /home/test/pyd-matrix-math
    pytest
EOT
