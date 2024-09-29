# Vagrant Mmatrix Math
Конфигурация виртуальной машины для `Vagrant`.
Данная виртуальная машина предназначена для запуска и тестирования модуля [Matrix Math](https://github.com/anfrostdev/pyd-matrix-math).

# Установка
1. Склонируйте репозиторий
```bash
git clone https://github.com/anfrostdev/vagrant-matrix-math.git
```
2.	Запустите файл `"run.cmd"`.

# Использование
1. Подключитесь к виртуальной машине по SSH используя имя пользователя "test” и пароль "test".
```
ssh.exe -o PubkeyAuthentication=no -o PreferredAuthentications=password test@localhost -p 2222
```
2. Перейдите в домашний каталог пользователя
```bash
$ cd ~/
```
3. Запустите тестирование
```bash
$ tox
```
4. Запустите скрипт модуля перемножения матриц
```bash
$ python3 MatrixMathLauncher.py matrix1.txt matrix2.txt result.txt
```
