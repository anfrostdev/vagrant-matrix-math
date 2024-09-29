Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/jammy64"
  config.vm.provision :shell, path: "install.sh", privileged: true
  config.vm.boot_timeout = 300
end
