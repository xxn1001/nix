{ pkgs,  ... }:
{
  environment.systemPackages = with pkgs; [
    qemu_kvm
    libvirt
    cloud-hypervisor
    passt
  ];
}
