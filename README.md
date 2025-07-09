# Buffer marks
Easily Mark and switch to any buffer in Vim

## Introduction
Buffer marks adds another way to mark buffers instead of the default buffer
numbers.

Why? Because buffer numbers are not serial for your relevant buffers. Internal /
temporary buffers takes up new numbers so what you end up with for your buffers
are numbers which are not at all serial.

And you have to type `:b <buffer_number>` to move between buffers.

Buffer marks allows you to mark buffers with any key and then easily switch to
it later

## Installation
Just clone this repo to the Vim package directory like below (assuming your
`vimrc` is located in `$HOME/.config/vim`)

```shell
cd $HOME/.config/vim/pack/vim/start
git clone https://github.com/riturajborpujari/buffer-marks.vim
```

Restart vim and you're done.

## Usage

### Mark a buffer
Run vim command `:Mark` to mark a buffer with your desired char.

For example run `:Mark` and then press `a` to mark the current buffer with `a`.

### Go to a marked buffer
Run vim command `:GoToMark` and then press any key to go to the buffer marked
with the char defined by that key.

For example run `:GoToMark` and then press `a` to go to the buffer marked as
`a`.

## Customizing shortcuts
You can add your custom keybinds to call `:Mark` and `:GoToMark` to let you use
buffer marks the way you want.

Here's an example keybind config
```vim
nnoremap <silent> <leader>m :Mark<cr>
nnoremap <silent> <leader>o :GoToMark<cr>
```

With this you press `<leader>m` and then `a` to mark a buffer as `a`, and then
to go to that buffer from anywhere, you press `<leader>o` and then `a`
