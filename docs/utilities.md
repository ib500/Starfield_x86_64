Explorar el contenido de un binario objeto o ejecutable
    objdump -D -M intel <binario>
    readelf -a <binario>
Ensamblar
    as <input_file> -g -I<dir> -o <output_file>
        -g : incluye símbolos de depuración, para poder usar el debugger
        -I<dir> : Hace que as mire en el directorio <dir> para buscar ficheros cuando se hace .include
        -o <output_file> : indicamos nombre del fichero intermedio de salida tras ensamblar (normalmente con extensión .o)
Enlazar
    gcc -nostartupfiles -nolibc -static <fichero.o>.....<fichero.o> -o <fichero_ejecutable>
        -nostartupfiles : No añade el código de inicialización que llama a main en C.
        -nolibc : No enlaza con la librería estándar de C
        -nostdlib : Hace lo mismo que -nolibc y -nostartupfiles juntos
        -static : Enlaza el código de forma estática, no requiriendo librerías dinámicas al ejecutar ni código independiente de la posición (PIE).
        -o <fichero_ejecutable> : Pone nombre al ejecutable resultado del enlazado
Depurar
    gdb ./<fichero_ejecutable>
        Comandos en GDB
            set disassembly-flavor intel: Cambia al modo intel para desensamblar (en vez de AT&T)
            b _start : Pone un (breakpoint) en el símbolo _start. Esto hay que hacerlo siempre al empezar, antes de hacer run. Podemos poner breakpoints en cualquier símbolo global.
            r : (run) Ejecuta el código, deteniéndose sólo en breakpoints
            c : (continue) Continua ejecutando el código sin detenerse, tras una parada en un breakpoint.
            ni: (next instruction) Ejecuta una única instrucción. Si es un CALL, hace la llamada entera, hasta el RET, como si fuera todo 1 instrucción (se salta la rutina).
            si: (step instruction) Ejecuta una única instrucción. Si es un CALL, sólo ejecuta el salto, parando en la primera instrucción de la llamada (dentro de la rutina).
            p $reg: (print) Imprime el valor del registro reg.
            p <expression>: Calcula la expresión e imprime el resultado (podemos ponerle operaciones matemáticas, por ejemplo)
            l : (list) lista el código en la posición actual de RIP
            q: (quit) Sale del depurador
            tui enable: Activa una interfaz visual con TUI (Text User Interface)
            tui reg general: Muestra los registros en la interfaz TUI
            [CTRL]+[X], [2]: Pulsando estas teclas, cambia el modo de la interfaz TUI para ver distintas cosas
            refresh: refresca la interfaz TUI (a veces es necesario)