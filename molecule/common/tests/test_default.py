import os

import testinfra.utils.ansible_runner

testinfra_hosts = testinfra.utils.ansible_runner.AnsibleRunner(
    os.environ['MOLECULE_INVENTORY_FILE']).get_hosts('all')


def test_hosts_file(host):
    f = host.file('/etc/hosts')

    assert f.exists
    assert f.user == 'root'
    assert f.group == 'root'


def test_packages(host):
    assert host.package("python3").is_installed
    assert host.package("python3-pip").is_installed
    assert host.package("docker-ce").is_installed


def test_docker(host):
    ansible_facts = host.ansible.get_variables()
    # assert host.docker("cadvisor").is_running
    assert host.docker("node-exporter").is_running
    if ansible_facts['inventory_hostname'] == 'ubuntu1804-boot':
        assert host.docker("haya-wallet").is_running
        assert host.docker("haya-boot").is_running
    if ansible_facts['inventory_hostname'] == 'ubuntu1804-producer':
        assert host.docker("haya-prod").is_running
    if ansible_facts['inventory_hostname'] == 'ubuntu1804-fullnode':
        assert host.docker("haya-prod").is_running


def test_wallet(host):
    ansible_facts = host.ansible.get_variables()
    if ansible_facts['inventory_hostname'] == 'ubuntu1804-boot':
        assert host.file('/opt/haya/haya-cli/wallet.password').exists
        assert host.file('/opt/haya/haya-cli/wallet.password').size > 0
