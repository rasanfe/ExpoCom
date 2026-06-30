# ExpoCom — Consumir una clase .NET desde PowerBuilder 🧩

![PowerBuilder](https://img.shields.io/badge/PowerBuilder-2025-FF6C2C?style=flat-square)
![.NET](https://img.shields.io/badge/.NET-10-512BD4?style=flat-square&logo=dotnet&logoColor=white)
![DLL Importer](https://img.shields.io/badge/.NET-DLL%20Importer-1F6FEB?style=flat-square)
![Blog](https://img.shields.io/badge/blog-rsrsystem-FF5722?style=flat-square&logo=blogger&logoColor=white)

Ejemplo **mínimo** (de expo/charla) para enseñar lo esencial: cómo PowerBuilder 2025 llama a una
clase .NET con el **.NET DLL Importer**, sin florituras.

---

## 📋 ¿Qué es esto?

Un cliente PowerBuilder (`expocomclient`) que consume la librería .NET **`COMServer`** como
`dotnetobject`. El IDE genera el proxy `nvo_server`, que:

- Carga el ensamblado con `is_assemblypath = "COMServer.dll"`.
- Instancia la clase `is_classname = "COMServer.Server"`.
- Llama al método demo **`ComputePi()`**, que devuelve un `double` desde .NET a PB.

Es el "hola mundo" del puente PB ↔ .NET: cargar una DLL, crear el objeto y llamar a un método. El
proxy envuelve la llamada en `Try…Catch(runtimeerror)` y, si algo falla al cargar/crear/invocar,
registra el error (`of_SetDotNETError` / `of_SetAssemblyError`) en lugar de reventar.

---

## 🔗 Motor .NET

La librería es **`COMServer`**, una biblioteca .NET con la clase `COMServer.Server` y un método de
demostración **`ComputePi`** que calcula y devuelve el número Pi como `double`.

- **Repo .NET:** <https://github.com/rasanfe/COMServer>
- **Código fuente** (Visual Studio, .NET 10): `Blog\Net10\COMServer\`
- **DLL desplegada:** `COMServer.dll`, junto al ejecutable del cliente en la raíz de `ExpoCom\`.

---

## 🛠️ Requisitos

- **PowerBuilder 2025**.
- **.NET 10** (runtime para `COMServer.dll`).

## ▶️ Cómo probarlo

1. Abre el *workspace* `expocomclient.pbsln` en el IDE de PowerBuilder.
2. Asegúrate de que `COMServer.dll` está junto al ejecutable.
3. Compila y ejecuta `w_main`.
4. Lanza la acción que invoca `of_computepi()` y verás el valor de Pi devuelto por la clase .NET.

### Estructura

```
ExpoCom/
├── expocomclient.pbl/   # App, ventana w_main y proxy nvo_server (dotnetobject)
├── COMServer.dll        # Librería .NET (clase COMServer.Server, método ComputePi)
├── expocomclient.pbsln  # Workspace
└── logo.jpg / icono.ico
```

---

## 🔗 Repo PowerBuilder

- **PowerBuilder (modo solución):** <https://github.com/rasanfe/ExpoCom>
- **Motor .NET (COMServer):** <https://github.com/rasanfe/COMServer>

---

> ¡Nos vemos en el próximo artículo! Y recuerda: en PowerBuilder, los límites solo están en nuestra imaginación. 🚀

📨 **Blog:** <https://rsrsystem.blogspot.com/>
