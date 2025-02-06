# Real Estate

Esta aplicación es la interfaz de usuario para manejar las operaciones CRUD para propiedades, está construída en Flutter.

## Instalación

Instala el SDK de Flutter siguiendo las instrucciones de esta página https://docs.flutter.dev/get-started/install

* Clona el repositorio
```bash
    git clone https://github.com/blascorrea/real_estate_front.git
```
* Ir a la carpeta clonada en el PC e instala las dependencias
```bash
    cd /path/to/project
    flutter pub get
```
* Edita el archivo /lib/utils/constants.dart dentro del proyecto, cambiando IP por la IP del PC y PORT por el puerto elegido para la aplicación servidor https://github.com/blascorrea/real_estate_back.git
```bash
    const BASE_URL = 'http://IP:PORT/api';
```
* Ejecuta la aplicación
```bash
    flutter run --debug
```

El anterior comando muestra los dispositivos conectados y disponibles para ejecutar la aplicación
