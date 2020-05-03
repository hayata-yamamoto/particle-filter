# Python

## Usage
**local**
```bash
$ curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python3
$ poetry config virtualenvs.in-project true
$ poetry install --no-dev
```

**docker**

```bash
$ docker build -t pf .
$ docker run -it --rm pf
```

## Versions

**Poetry**
```bash
$ poetry --version
Poetry version 1.0.2
```
