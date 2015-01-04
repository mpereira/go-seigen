# 吳清源

![Go Seigen VS Kitani Minoru](https://raw.github.com/mpereira/go-seigen/master/resources/go_seigen_vs_kitani_minoru.png)

## Dependencies

- [PureScript](http://www.purescript.org/download/)
- [pulp](https://www.npmjs.com/package/pulp)
- [npm](http://nodejs.org/download/)

## Install

```Bash
git clone https://github.com/mpereira/go-seigen.git
cd go-seigen
npm install
pulp dep install
pulp browserify --to output/bundle.js
```

## Run

```Bash
python -m SimpleHTTPServer 3000
open http://localhost:3000
```

## License
MIT

## Author
[Murilo Pereira](http://murilopereira.com)
