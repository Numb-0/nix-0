<div align="center">   
    <img src="./docs/assets/nix0_banner.svg">
    </br>
    <b style="color:#8aadf4; font-size:24px;"> ❄ NixOs configuration ❄</b>
</div>

# Installation
1. **Clone the repository** in the home directory or where you want:
```bash
git clone https://github.com/Numb-0/nix-0.git ~/nix-0
```
2. **Navigate to directory**
```bash
cd ~/nix-0
```
3. **Apply flake configuration**
```bash
sudo nixos-rebuild switch --flake .#nixos
```