.pragma library

var TABS = [
    {
        id: "vscode", label: "VSCODE",
        commands: [
            { key: "Ctrl+P",          desc: "Abrir archivo rápido" },
            { key: "Ctrl+Shift+P",    desc: "Paleta de comandos" },
            { key: "Ctrl+`",          desc: "Toggle terminal integrado" },
            { key: "Ctrl+Shift+`",    desc: "Nuevo terminal" },
            { key: "Ctrl+B",          desc: "Toggle sidebar" },
            { key: "Ctrl+/",          desc: "Comentar / descomentar línea" },
            { key: "Ctrl+D",          desc: "Seleccionar siguiente ocurrencia" },
            { key: "Ctrl+Shift+K",    desc: "Eliminar línea" },
            { key: "Alt+Up/Down",     desc: "Mover línea arriba/abajo" },
            { key: "F12",             desc: "Ir a definición" },
            { key: "Alt+F12",         desc: "Vista previa de definición" },
            { key: "Ctrl+Shift+F",    desc: "Buscar en todos los archivos" },
            { key: "Ctrl+Shift+G",    desc: "Panel de control de versiones" },
            { key: "Ctrl+Shift+X",    desc: "Panel de extensiones" },
            { key: "Ctrl+Tab",        desc: "Cambiar entre pestañas abiertas" },
            { key: "Ctrl+W",          desc: "Cerrar editor activo" },
            { key: "Ctrl+K Z",        desc: "Modo zen (pantalla completa limpia)" },
            { key: "Ctrl+Shift+E",    desc: "Panel explorador de archivos" }
        ]
    },
    {
        id: "vim", label: "VIM",
        commands: [
            { key: ":w",              desc: "Guardar archivo" },
            { key: ":q",              desc: "Salir" },
            { key: ":wq  /  ZZ",      desc: "Guardar y salir" },
            { key: ":q!",             desc: "Salir sin guardar" },
            { key: "i / a / o",       desc: "Insertar: antes / después / nueva línea" },
            { key: "Esc",             desc: "Volver a modo normal" },
            { key: "dd",              desc: "Eliminar línea" },
            { key: "yy",              desc: "Copiar línea" },
            { key: "p / P",           desc: "Pegar debajo / encima" },
            { key: "u",               desc: "Deshacer" },
            { key: "Ctrl+R",          desc: "Rehacer" },
            { key: "gg / G",          desc: "Ir al inicio / final del archivo" },
            { key: "/texto",          desc: "Buscar texto hacia adelante" },
            { key: "n / N",           desc: "Siguiente / anterior resultado" },
            { key: ":%s/old/new/g",   desc: "Reemplazar en todo el archivo" },
            { key: "Ctrl+V",          desc: "Modo selección en bloque" },
            { key: "ci\"",            desc: "Cambiar contenido entre comillas" },
            { key: "va{",             desc: "Seleccionar bloque con {}" },
            { key: ":set nu",         desc: "Mostrar números de línea" },
            { key: ":noh",            desc: "Quitar resaltado de búsqueda" }
        ]
    },
    {
        id: "nvim", label: "NVIM",
        commands: [
            { key: ":Lazy",           desc: "Gestor de plugins (lazy.nvim)" },
            { key: ":Mason",          desc: "Gestor LSP / linters / formatters" },
            { key: "gd",              desc: "Ir a definición" },
            { key: "gr",              desc: "Ver referencias" },
            { key: "K",               desc: "Hover documentación" },
            { key: "<leader>ff",      desc: "Buscar archivos (Telescope)" },
            { key: "<leader>fg",      desc: "Live grep en el proyecto" },
            { key: "<leader>fb",      desc: "Listar buffers abiertos" },
            { key: "<leader>e",       desc: "Toggle file explorer (NvimTree)" },
            { key: "Ctrl+h/j/k/l",   desc: "Navegar entre ventanas/splits" },
            { key: ":bd",             desc: "Cerrar buffer actual" },
            { key: ":sp  /  :vsp",    desc: "Split horizontal / vertical" },
            { key: "<leader>ca",      desc: "Code actions (LSP)" },
            { key: "[d  /  ]d",       desc: "Diagnóstico anterior / siguiente" },
            { key: "<leader>rn",      desc: "Renombrar símbolo (LSP)" }
        ]
    },
    {
        id: "linux", label: "LINUX",
        commands: [
            { key: "ls -la",                      desc: "Listar archivos con permisos" },
            { key: "ls -lhS",                     desc: "Listar archivos ordenados por tamaño" },
            { key: "cd -",                         desc: "Volver al directorio anterior" },
            { key: "cp -r origen/ destino/",       desc: "Copiar carpeta recursiva" },
            { key: "wc -l archivo.txt",            desc: "Contar líneas de un archivo" },
            { key: "Ctrl+C",                       desc: "Interrumpir proceso activo" },
            { key: "Ctrl+Z",                       desc: "Suspender proceso (reanudar con fg)" },
            { key: "Ctrl+R",                       desc: "Buscar en historial de comandos" },
            { key: "history | grep cmd",           desc: "Buscar comando en historial" },
            { key: "!!",                           desc: "Repetir último comando" },
            { key: "sudo !!",                      desc: "Repetir último comando como sudo" },
            { key: "!$",                           desc: "Último argumento del comando anterior" },
            { key: "grep -r \"txt\" .",            desc: "Buscar texto recursivamente" },
            { key: "find . -name \"*.ext\"",       desc: "Buscar archivos por nombre" },
            { key: "find . -name \"*.log\" -mtime +7 -delete", desc: "Borrar logs de más de 7 días" },
            { key: "chmod +x script.sh",           desc: "Hacer archivo ejecutable" },
            { key: "chmod 644 archivo",            desc: "Permisos rw-r--r-- (lectura pública)" },
            { key: "chown user:group archivo",     desc: "Cambiar dueño y grupo" },
            { key: "whoami",                       desc: "Mostrar usuario actual" },
            { key: "tar -czvf arch.tar.gz dir/",   desc: "Comprimir carpeta con tar+gzip" },
            { key: "tar -xzf archivo.tar.gz",      desc: "Extraer archivo .tar.gz" },
            { key: "tar -xjvf archivo.tar.bz2",    desc: "Extraer archivo .tar.bz2" },
            { key: "unzip arch.zip -d dir/",       desc: "Extraer ZIP en carpeta" },
            { key: "zip -r salida.zip dir/",       desc: "Comprimir carpeta en ZIP" },
            { key: "curl -O URL",                  desc: "Descargar archivo con curl" },
            { key: "wget -c URL",                  desc: "Descargar archivo (reanudable)" },
            { key: "curl -I URL",                  desc: "Ver cabeceras HTTP" },
            { key: "ping -c 4 host",               desc: "Ping N veces a un host" },
            { key: "ss -tlnp",                     desc: "Ver puertos en escucha (Linux)" },
            { key: "lsof -i :3000",                desc: "Qué proceso usa el puerto 3000" },
            { key: "ps aux | grep nombre",         desc: "Buscar proceso por nombre" },
            { key: "kill -9 PID",                  desc: "Terminar proceso por PID" },
            { key: "top",                          desc: "Monitor de procesos interactivo" },
            { key: "df -h",                        desc: "Uso de disco del sistema" },
            { key: "du -sh *",                     desc: "Tamaño de carpetas del directorio" },
            { key: "free -h",                      desc: "Memoria RAM disponible (Linux)" },
            { key: "which cmd",                    desc: "Mostrar ruta de un comando" }
        ]
    },
    {
        id: "docker", label: "DOCKER",
        commands: [
            { key: "docker ps",                   desc: "Listar contenedores activos" },
            { key: "docker ps -a",                desc: "Listar todos los contenedores" },
            { key: "docker images",               desc: "Ver imágenes locales" },
            { key: "docker pull img:tag",         desc: "Descargar imagen del registry" },
            { key: "docker run -d -p 8080:80 --name n img", desc: "Correr contenedor en background" },
            { key: "docker exec -it nombre bash", desc: "Entrar al contenedor con bash" },
            { key: "docker logs -f nombre",       desc: "Ver logs en tiempo real" },
            { key: "docker stop n && docker rm n",desc: "Detener y eliminar contenedor" },
            { key: "docker cp file.txt n:/ruta/", desc: "Copiar archivo al contenedor" },
            { key: "docker inspect nombre",       desc: "Info detallada del contenedor" },
            { key: "docker stats",                desc: "Uso CPU/RAM de contenedores en vivo" },
            { key: "docker build -t nombre:tag .",desc: "Construir imagen desde Dockerfile" },
            { key: "docker rmi imagen",           desc: "Eliminar imagen local" },
            { key: "docker tag img:tag repo/img:tag", desc: "Etiquetar imagen para registry" },
            { key: "docker push repo/img:tag",    desc: "Subir imagen al registry" },
            { key: "docker volume ls",            desc: "Listar volúmenes" },
            { key: "docker volume rm nombre",     desc: "Eliminar volumen" },
            { key: "docker system prune -af",     desc: "Limpiar todo lo no usado" },
            { key: "docker compose up -d",        desc: "Iniciar servicios en background" },
            { key: "docker compose up -d --build",desc: "Rebuild y levantar servicios" },
            { key: "docker compose down",         desc: "Detener y eliminar contenedores" },
            { key: "docker compose down -v",      desc: "Bajar + eliminar volúmenes" },
            { key: "docker compose build",        desc: "Reconstruir imágenes del compose" },
            { key: "docker compose logs -f svc",  desc: "Logs en tiempo real de un servicio" },
            { key: "docker compose exec svc bash",desc: "Shell en un servicio" },
            { key: "docker compose ps",           desc: "Estado de los servicios" },
            { key: "docker compose restart svc",  desc: "Reiniciar un servicio" },
            { key: "docker compose pull",         desc: "Actualizar imágenes del compose" }
        ]
    },
    {
        id: "git", label: "GIT",
        commands: [
            { key: "git status",              desc: "Ver estado del repositorio" },
            { key: "git add .",               desc: "Agregar todos los cambios al stage" },
            { key: "git commit -m \"\"",      desc: "Crear commit con mensaje" },
            { key: "git push",                desc: "Subir cambios al remoto" },
            { key: "git pull",                desc: "Bajar y fusionar cambios del remoto" },
            { key: "git branch -a",           desc: "Ver todas las ramas (local y remota)" },
            { key: "git checkout -b nombre",  desc: "Crear y cambiar a nueva rama" },
            { key: "git merge branch",        desc: "Fusionar rama en la actual" },
            { key: "git rebase main",         desc: "Reorganizar commits sobre main" },
            { key: "git stash",               desc: "Guardar cambios sin commitear" },
            { key: "git stash pop",           desc: "Restaurar último stash" },
            { key: "git log --oneline",       desc: "Ver historial de commits resumido" },
            { key: "git log --oneline --graph", desc: "Historial con árbol de ramas visual" },
            { key: "git diff",                desc: "Ver cambios sin commitear" },
            { key: "git diff --stat HEAD~1",  desc: "Resumen de cambios del último commit" },
            { key: "git reset HEAD^",         desc: "Deshacer último commit (soft, conserva cambios)" },
            { key: "git reset --hard HEAD~1", desc: "Deshacer último commit (destructivo)" },
            { key: "git clean -fd",           desc: "Eliminar archivos sin rastrear" },
            { key: "git cherry-pick hash",    desc: "Aplicar commit específico a la rama" }
        ]
    },
    {
        id: "gitflow", label: "GIT FLOW",
        commands: [
            // ── Tipos de commit (Conventional Commits) ─────────────────────
            { key: "feat: ",         desc: "Nueva funcionalidad para el usuario" },
            { key: "fix: ",          desc: "Corrección de un bug" },
            { key: "refactor: ",     desc: "Refactorización sin cambio de comportamiento" },
            { key: "chore: ",        desc: "Mantenimiento: deps, build, configs, limpieza" },
            { key: "docs: ",         desc: "Cambios solo en documentación" },
            { key: "style: ",        desc: "Formato, espacios, comas (sin lógica)" },
            { key: "test: ",         desc: "Agregar o corregir tests" },
            { key: "perf: ",         desc: "Mejora de rendimiento" },
            { key: "ci: ",           desc: "Cambios en pipelines / workflows de CI" },
            { key: "build: ",        desc: "Sistema de build o dependencias externas" },
            { key: "revert: ",       desc: "Revertir un commit anterior" },
            // ── Breaking change ─────────────────────────────────────────────
            { key: "feat!: ",        desc: "BREAKING CHANGE: funcionalidad incompatible" },
            { key: "fix!: ",         desc: "BREAKING CHANGE: fix que rompe compatibilidad" },
            // ── Ramas ───────────────────────────────────────────────────────
            { key: "feature/nombre", desc: "Rama para nueva funcionalidad" },
            { key: "bugfix/nombre",  desc: "Corrección de bug (no urgente)" },
            { key: "hotfix/nombre",  desc: "Fix urgente directamente sobre producción" },
            { key: "release/x.y.z",  desc: "Preparación de release (freeze + bumps)" },
            { key: "chore/nombre",   desc: "Mantenimiento, limpieza, actualizaciones" }
        ]
    },
    {
        id: "ssh", label: "SSH",
        commands: [
            { key: "ssh usuario@host",                         desc: "Conectar al servidor" },
            { key: "ssh -p 2222 usuario@host",                 desc: "Conectar por puerto custom" },
            { key: "ssh -i ~/.ssh/clave.pem usuario@host",     desc: "Conectar con clave privada" },
            { key: "ssh-keygen -t ed25519 -C \"email\"",       desc: "Generar par de llaves SSH" },
            { key: "ssh-copy-id usuario@host",                 desc: "Copiar clave pública al servidor" },
            { key: "scp archivo.txt usuario@host:/ruta/",      desc: "Copiar archivo al servidor" },
            { key: "scp -r usuario@host:/ruta/ ./local/",      desc: "Descargar carpeta del servidor" },
            { key: "ssh -L 8080:localhost:80 usuario@host",    desc: "Tunnel: puerto local → remoto" },
            { key: "ssh -N -f -L 5432:localhost:5432 u@host",  desc: "Tunnel de BD en background" }
        ]
    },
    {
        id: "ffmpeg", label: "FFMPEG",
        commands: [
            { key: "ffmpeg -i entrada.mov -c copy salida.mp4",         desc: "MOV → MP4 sin recodificar" },
            { key: "ffmpeg -i entrada.mp4 -vn -acodec mp3 audio.mp3",  desc: "Extraer audio a MP3" },
            { key: "ffmpeg -i entrada.mp4 -vf scale=1280:720 sal.mp4", desc: "Redimensionar video" },
            { key: "ffmpeg -i entrada.mp4 -ss 00:01:00 -t 30 clip.mp4",desc: "Recortar: desde 1min, 30 seg" },
            { key: "ffmpeg -i entrada.mp4 -r 24 salida.mp4",           desc: "Cambiar framerate a 24fps" },
            { key: "ffmpeg -i imagen.png imagen.jpg",                   desc: "Convertir formato de imagen" },
            { key: "ffmpeg -i entrada.mp4 -vframes 1 frame.jpg",       desc: "Capturar primer frame del video" },
            { key: "convert -resize 800x imagen.png salida.png",       desc: "Redimensionar imagen (ImageMagick)" },
            { key: "convert -quality 80 entrada.jpg salida.jpg",       desc: "Comprimir JPEG (ImageMagick)" }
        ]
    },
    {
        id: "regex", label: "REGEX",
        commands: [
            // ── Clases de caracteres ────────────────────────────────────────
            { key: "\\d",                              desc: "Dígito [0-9]" },
            { key: "\\D",                              desc: "No dígito" },
            { key: "\\w",                              desc: "Alfanumérico + guión bajo [a-zA-Z0-9_]" },
            { key: "\\W",                              desc: "No alfanumérico" },
            { key: "\\s",                              desc: "Espacio en blanco (space, tab, newline)" },
            { key: "\\S",                              desc: "No espacio en blanco" },
            { key: "\\b",                              desc: "Límite de palabra (word boundary)" },
            { key: ".",                                desc: "Cualquier carácter excepto salto de línea" },
            // ── Cuantificadores ─────────────────────────────────────────────
            { key: "*",                                desc: "0 o más (greedy)" },
            { key: "+",                                desc: "1 o más (greedy)" },
            { key: "?",                                desc: "0 o 1 (opcional)" },
            { key: "*?",                               desc: "0 o más (lazy / no greedy)" },
            { key: "+?",                               desc: "1 o más (lazy / no greedy)" },
            { key: "{n,m}",                            desc: "Entre n y m repeticiones" },
            // ── Anchors ─────────────────────────────────────────────────────
            { key: "^",                                desc: "Inicio de línea" },
            { key: "$",                                desc: "Fin de línea" },
            // ── Grupos ──────────────────────────────────────────────────────
            { key: "(abc)",                            desc: "Grupo de captura" },
            { key: "(?:abc)",                          desc: "Grupo sin captura" },
            { key: "(?<name>abc)",                     desc: "Grupo con nombre" },
            { key: "(?=abc)",                          desc: "Lookahead positivo (seguido de abc)" },
            { key: "(?!abc)",                          desc: "Lookahead negativo (no seguido de abc)" },
            { key: "(?<=abc)",                         desc: "Lookbehind positivo (precedido de abc)" },
            { key: "(?<!abc)",                         desc: "Lookbehind negativo (no precedido de abc)" },
            { key: "a|b",                              desc: "Alternación (a o b)" },
            // ── Flags ───────────────────────────────────────────────────────
            { key: "/patrón/gi",                       desc: "Flags: g=global  i=insensible  m=multilinea  s=dotAll" },
            // ── Patrones comunes ─────────────────────────────────────────────
            { key: "[\\w.+-]+@[\\w-]+\\.[a-zA-Z]{2,}", desc: "Email" },
            { key: "https?://[\\w/%#$&?()~.=+-]+",    desc: "URL (http / https)" },
            { key: "\\b\\d{1,3}(\\.\\d{1,3}){3}\\b",  desc: "Dirección IPv4" },
            { key: "\\d{4}-\\d{2}-\\d{2}",            desc: "Fecha ISO 8601 (yyyy-mm-dd)" },
            { key: "#([0-9a-fA-F]{3}|[0-9a-fA-F]{6})\\b", desc: "Color hexadecimal CSS" },
            { key: "[a-z0-9]+(?:-[a-z0-9]+)*",        desc: "Slug URL (kebab-case)" },
            { key: "[0-9a-f]{8}(-[0-9a-f]{4}){3}-[0-9a-f]{12}", desc: "UUID v4" }
        ]
    }
]
