# dotfiles

All of my dotfiles,
These are managed by [yadm](https://github.com/TheLocehiliosan/yadm)


# Showcase
## i3!

[image](https://user-images.githubusercontent.com/28804392/228485295-91a352a6-7261-402a-a948-ecb57d2a5eab.png)

TODO

## HYPRLAND

# Apply the configs

### install yadm

```sh
sudo pacman -Sy yadm
```

#### i would say fork this repo and then install it using yadm here the way you do it so just change the github link to your fork

```
yadm clone https://github.com/Rishabh672003/dotfiles
```

#### Explaination of yadm

let me explain how yadm works because i couldnt figure it out for the first few
days that i used it
what yadm does is use your home directory as a git repo but doesnt adds anything to the git repo where the .git directory stays is in `~/.local/share/yadm/repo.git/`
#### Get started

easiest way to get started is make a bare git repo in github or gitlab and do a
`yadm clone "link of your repo"`
that will clone the repo in the repo.git that i mentioned above
aftet that using yadm is just like using git you can do any git command with yadm like `yadm add` or `yadm clone` and all 
so just add the dotfiles you need to save by doing `yadm add "path of file"`
than commit by using `yadm commit -am "your message"` and push by using `yadm push`
one extra yadm command which i recommend you learn is `yadm enter` using that will put you in a shell where you can just manipulate the yadm repo by just using git commands and you can also use apps like lazygit for the dotfiles repo which you cant do by default


# References: 
[Rishabh672003](https://github.com/Rishabh672003/dotfiles) For some parts of the dotfiles and the nice readme xd
