# Black Ops 3 Source

Dump of some parts of BO3 using [Atian Call of Duty Tools](https://github.com/ate47/atian-cod-tools), please create an issue on the tools directory if you find a strange decompiled code.

It's a simple port of my tools I've made because I was bored, you can probably find a better one somewhere else.

## Pools

Pools dumped ([List of all the pools](https://github.com/ate47/t8-atian-menu/blob/master/docs/notes/xassetpools_bo3.csv))

| name                    | id  | path                                |
| ----------------------- | --- | ----------------------------------- |
| rawfile                 | 47  | `/`                                 |
| stringtable             | 48  | `/`                                 |
| structuredtable         | 49  | `/`                                 |
| scriptparsetree\*       | 54  | `/vm-VM/`                           |
| scriptbundle            | 69  | `/scriptbundle/`                    |


\* I don't why, but the game has scripts with 2 different VMs loaded. `vm-1c` are the scripts used by the game.