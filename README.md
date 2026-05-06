# Diamante

Presentar diapositivas en el temrinal.

## Instalación

* Instalar Ruby.
* Instalar la gema `gem install diamante`

## Modo de uso

* Crear una carpeta con el fichero de configuración YAML y las diapositivas en ficheros de texto. [Ver ejemplo](./examples/yaml/).
* Abrir un terminal.
* Ejecutar `diamante show PATH/TO/CONFIG.yaml`.

## Características

* El contenido de cada diapositiva va en un fichero de texto separado.
* El fichero de configuración tiene el siguiente formato:
```yaml
:header: "Gema diamante"
:files: "examples/yaml/*.txt"
:bye: "Morpheus: 'Follow me.'"
```

Significado de los parámetros:

| Parámetro | Descripción |
| --------- | ----------- |
| `:header` | Título de la presentación |
| `:files`  | Ficheros de texto que contienen las diapositivas |
| `:bye`    | Mensaje de despedida |

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/dvarrui/diamante.

