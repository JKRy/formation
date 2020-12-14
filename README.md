# 🐝 Formation <a href="https://www.patreon.com/minamarkham"><img src="https://c5.patreon.com/external/logo/become_a_patron_button@2x.png" width="100"></a>

![Let's get in formation](assets/formation.gif)

> Formation is a shell script to set up a macOS laptop for design and development.

It can be run multiple times on the same machine safely. It installs, upgrades, or skips packages based on what is already installed on the machine.

## Install

Download the script:

```sh
mkdir -p /Users/$(whoami)/code/personal/dotfiles

cd /Users/$(whoami)/code/personal/dotfiles

curl -L https://github.com/jessicakryan/formation/tarball/jess-updates | tar -xzv --strip-components 1 &> /dev/null;

```

Review the script (please don't run scripts you don't understand):

```sh
less slay
```

Slay:

```sh
./slay 2>&1 | tee ~/slay.log
```

Just follow the prompts and you’ll be fine. 👌

:warning: Warning: I advise against running [this script](slay) unless you understand what it’s doing to your computer.

I created this based on my own preferences; your mileage may vary.

Once the script is done, quit and relaunch Terminal.

It is highly recommended to run the script regularly to keep your computer up to date.

Your last Formation run will be saved to `~/slay.log`. To review it, run `less ~/slay.log`.

That's it! :sparkles:

## What it sets up

The setup process will install:

<details>
<summary>Basic tools:</summary>

-   [XCode Command Line Tools](https://developer.apple.com/xcode/downloads/) for developer essentials.
-   [Git](https://git-scm.com/) for version control
-   [Homebrew](http://brew.sh/) for managing operating system libraries.
</details>

<details>
<summary>Package Managers:</summary>

-   [NVM](https://github.com/creationix/nvm/) for managing and installing multiple versions of [Node.js](http://nodejs.org/) and [npm](https://www.npmjs.org/)
</details>

<details>
<summary>CLI Tools & Utilities:</summary>

-   [Hotel](https://github.com/typicode/hotel), a simple process manager for developers
-   [mas](https://github.com/mas-cli/mas) Mac App Store command line interface
</details>

### Apps

<details>
<summary>Productivity</summary>

-   [Spark](https://sparkmailapp.com/) for a better mail client.
-   [Alfred](https://www.alfredapp.com/) for increased productivity and efficiency with macOS.
</details>

<details>
<summary>Development</summary>

-   [iTerm](https://www.iterm2.com/) for a better terminal.
-   [Visual Studio Code](https://code.visualstudio.com/) IDE
-   [Trailer](http://ptsochantaris.github.io/trailer/) GitHub Workflow
-   [Insomnia](https://insomnia.rest/download/#mac) API Client
-   [Charles](https://www.charlesproxy.com/)
-   [Docker](https://www.docker.com/)

</details>

<details>
<summary>Communication</summary>

-   [Bear](http://www.bear-writer.com/) for writing and previewing markdown.
-   [Teams](https://www.microsoft.com/en-nz/microsoft-365/microsoft-teams/download-app)
-   [Zoom](https://zoom.us/)
-   [Whatsapp](https://www.whatsapp.com/)
</details>

<details>
<summary>Utilities</summary>

-   [Dashlane](https://www.dashlane.com/) for password management.
-   [Spectacle](https://www.spectacleapp.com/) for better window management.
-   [Encrypto](https://macpaw.com/encrypto) for securing files.
-   [Private Internet Access](https://www.privateinternetaccess.com/) for privacy.
-   [Karabiner](https://pqrs.org/osx/karabiner/) for keyboard mapping.
-   [Amphetamine](https://apps.apple.com/us/app/amphetamine/id937984704) keep-awake utility
-   [EasyFind](https://apps.apple.com/us/app/easyfind/id411673888)
-   [Purevpn](https://www.purevpn.com/)
-   [Trello](https://trello.com/)

</details>

<details>
<summary>Miscellaneous</summary>

-   [Rocket](http://matthewpalmer.net/rocket/) for Slack-like emojis.
-   [Spotify](https://www.spotify.com/) for music.
-   [VLC](http://www.videolan.org/) for a better media player.
-   [Skitch](https://apps.apple.com/us/app/skitch-snap-mark-up-share/id425955336?mt=12) for image mark up
-   [Adobe Acrobat Reader](https://get.adobe.com/reader/)
</details>

<details>
<summary>Browsers</summary>

-   [Blisk](https://blisk.io/) for cross-device web development.
-   [Chrome](https://www.google.com/chrome/browser/desktop/) for fast and free web browsing.
-   [MicrosoftEdge](https://www.microsoft.com/en-us/edge)
-   [Firefox](https://www.mozilla.org/en-US/firefox/new/)

</details>

<sub>See [`swag`](swag) for the full list of apps that will be installed. Adjust it to your personal taste.</sub>

It should take less than 20 minutes to install (depends on your machine).

## 🌶 Just add `~/.hot-sauce`

![I got hot sauce in my bag](assets/hot-sauce.gif)

Your `~/.hot-sauce` is added at the end of the Formation script. Put your customizations there.
For example:

```sh
#!/usr/bin/env bash

SETUP_ROOT=$HOME/.setup

NERDFONTS_RELEASE=$(curl -L -s -H 'Accept: application/json' https://github.com/ryanoasis/nerd-fonts/releases/latest)
NERDFONTS_VERSION=$(get_github_version $NERDFONTS_RELEASE)

DIRECTORIES=(
    $HOME/Desktop/screenshots
    $HOME/Tools
    $HOME/development
    $HOME/design
)

NERDFONTS=(
    SpaceMono
    Hack
    AnonymousPro
    Inconsolata
)

step "Making directories…"
for dir in ${DIRECTORIES[@]}; do
    mkd $dir
done

step "Installing fonts…"
for font in ${NERDFONTS[@]}; do
    if [ ! -d ~/Library/Fonts/$font ]; then
        printf "${indent}  [↓] $font "
        wget -P ~/Library/Fonts https://github.com/ryanoasis/nerd-fonts/releases/download/$NERDFONTS_VERSION/$font.zip --quiet;unzip -q ~/Library/Fonts/$font -d ~/Library/Fonts/$font
        print_in_green "${bold}✓ done!${normal}\n"
    else
        print_muted "${indent}✓ $font already installed. Skipped."
    fi
done
```

Write your customizations such that they can be run safely more than once.
See the `slay` script for examples.

Formation functions such as `step` and `link` can be used in your `~/.hot-sauce`.

## Known Issues

Cask does not recognize applications installed outside of Homebrew Cask – in the case that the script fails, you can either remove the application from the install list or uninstall the application causing the failure and try again.

## Acknowledgements

Inspiration and code was taken from many sources, including:

-   [Mathias Bynens'](https://github.com/mathiasbynens) [dotfiles](https://github.com/mathiasbynens/dotfiles)
-   thoughtbot's [laptop](https://github.com/thoughtbot/laptop/)

## 📜 License

Formation is customized for my own needs. It is free software, and may be redistributed under the terms specified in the [LICENSE] file.

[license]: LICENSE
