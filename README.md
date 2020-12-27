# mdne-sf - Markdown Neo Edit for Salesforce

<img src="https://raw.githubusercontent.com/shellyln/mdne-sf/master/docs/logo.svg?sanitize=true" title="logo" style="width: 200px">

### A simple markdown and code editor powered by [Markdown-it](https://github.com/markdown-it/markdown-it) and [Ace](https://ace.c9.io/).

![screenshot](https://raw.githubusercontent.com/shellyln/mdne-sf/master/docs/mdne-sf.png)


## Features
* Live preview of Markdown, HTML, [LSX](https://github.com/shellyln/liyad#what-is-lsx) formats.
* Export Markdown, HTML, and LSX into HTML.
* Code highlighting
  * C#
  * CSS
  * Dockerfile
  * Go
  * GraphQL
  * HTML
  * INI
  * Java
  * JavaScript
  * JSON
  * JSON5
  * JSX
  * Kotlin
  * Latex
  * Less
  * Lisp
  * Makefile
  * Markdown
  * Protobuf
  * Python
  * R
  * Ruby
  * Rust
  * Sass
  * Scss
  * Shell script
  * SQL
  * SVG
  * Tex
  * TOML
  * TSX
  * TypeScript
  * XML
  * YAML
* Markdown extended syntax
  * Many markdown-it plugins are enabled. See [here](https://github.com/shellyln/menneu#features).
* Scripting and value expansion
  * See [here](https://github.com/shellyln/menneu#lisp-block-expansion).
* Full screen mode (F11)

For more informations, see [mdne electron](https://github.com/shellyln/mdne-electron) repo.



## ⚙️ Setup a deployment and contribution environment

```bash
git clone https://github.com/shellyln/mdne-sf.git
cd mdne-sf
git checkout -b my-package-releases

# Authorize a Dev-Hub org (if you haven't already done).
sfdx force:auth:web:login \
    --setdefaultdevhubusername
    --setalias my-hub-org

sfdx force:org:create \
    --definitionfile config/project-scratch-def.json \
    --setalias MdneSfOrg \
    --durationdays 30 \
    --setdefaultusername
npm install

sfdx force:source:push
sfdx force:org:open

# and try it!
```



## 📖 Usage

### 🟢 Formula field to open the Markdown editor

1. Click `⚙️Setup` menu and click `⚙️Setup`.
1. Open `Object Manager` and select the object you want to add report. (e.g.: `Account`)
1. Select `Fields & Relationships` menu and click `New`.
    | Item | Value |
    |------|-------|
    | Object Name | `Account` |
    | Field Label | `Open Editor` |
    | Field Name | `OpenEditor` |
    | API Name | `OpenEditor__c` |
    | Data Type | `Formula (Text)` |
    | Formula | `HYPERLINK("/apex/mdne#open.obj=Account&open.field=Description&open.id=" & Id, "Open Editor", "_blank")` |
    | Blank Field Handling | `Treat blank fields as blanks` |
1. Click `Save` button.
1. Select `Page Layouts` menu and add the field to the layout.



### 🟢 Show the rendered markdown on the detail view page.

1. Make a copy Visualforce page `MarkdownPreviewExample_Account` and edit it.
1. Click `⚙️Setup` menu and click `⚙️Setup`.
1. Open `Object Manager` and select the object you want to add report. (e.g.: `Account`)
1. Select `Page Layouts` menu and add the copied Visualforce page to the layout.
    | Item | Value |
    |------|-------|
    | Width | `100%` |
    | Height | `200` |
    | Show scrollbars | `false` |
    | Show label | `false` |



## 📦 Deploy the package (pre-release)

```bash
sfdx force:org:list

# Specify the `USERNAME` or` ALIAS` of the DevHub org listed in the above command.
sfdx force:package:create \
    -n MDNE \
    -d "Report rendering library for Salesforce LWC and Visualforce" \
    -r force-app \
    -t Unlocked \
    -v <devhub_org_username_or_alias>

sfdx force:package:list

cat sfdx-project.json

sfdx force:package:version:create \
    -p MDNE \
    -d force-app \
    -k test1234 \
    -v <devhub_org_username_or_alias> \
    --codecoverage \
    --wait 10

sfdx force:package:version:list --verbose

git add .
git commit -m "v0.1.0-1"

# Install the package in your developer or sandbox org for testing.
sfdx force:package:install \
    -u <target_dev_or_sandbox_org_username_or_alias> \
    --package MDNE@0.1.0-1 \
    -k test1234 \
    --wait 10 \
    --publishwait 10 \
    --noprompt
```

## 🚀 Deploy the package (production-release)

```bash
# Promote the package version to production.
sfdx force:package:version:promote \
    -p MDNE@0.1.0-1 \
    -v <devhub_org_username_or_alias>

# Install the package in your production org.
sfdx force:package:install \
    -u <target_org_username_or_alias> \
    --package MDNE@0.1.0-1 \
    -k test1234 \
    --wait 10 \
    --publishwait 10 \
    --noprompt
```

## 🚧 Manage the package and package versions

```bash
sfdx force:package:version:list --verbose
sfdx force:package:version:delete -p 04tXXX
sfdx force:package:delete -p 0HoXXX
```


----
## License
[ISC](https://github.com/shellyln/mdne-sf/blob/master/LICENSE.md)  
Copyright (c) 2020 Shellyl_N and Authors.

## Bundled softwares' license

* [Ace](https://github.com/ajaxorg/ace): [license](https://github.com/ajaxorg/ace/blob/master/LICENSE) (BSD-3-Clause)
* [Carlo](https://github.com/GoogleChromeLabs/carlo): [license](https://github.com/GoogleChromeLabs/carlo/blob/master/LICENSE) (Apache License 2.0)
* [Materialize](https://materializecss.com/): [license](https://github.com/Dogfalo/materialize/blob/v1-dev/LICENSE) (MIT)
* [Normalize.css](https://necolas.github.io/normalize.css/): [license](https://github.com/necolas/normalize.css/blob/master/LICENSE.md) (MIT)
* [github-markdown-css](https://github.com/sindresorhus/github-markdown-css): [license](https://github.com/sindresorhus/github-markdown-css/blob/gh-pages/license) (MIT)
* [highlight.js](https://github.com/highlightjs/highlight.js): [license](https://github.com/highlightjs/highlight.js/blob/master/LICENSE) (BSD 3-Clause)
* [React](https://reactjs.org/): [license](https://github.com/facebook/react/blob/master/LICENSE) (MIT)
* [pako](https://github.com/nodeca/pako): [license](https://github.com/nodeca/pako/blob/master/LICENSE) (MIT + ZLIB)
* [dialog-polyfill](https://github.com/GoogleChrome/dialog-polyfill): [license](https://github.com/GoogleChrome/dialog-polyfill/blob/master/LICENSE) (BSD-3-Clause)
