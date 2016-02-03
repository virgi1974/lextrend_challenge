# lextrend_challenge
code challenge for lextrend

Lectura de datos - module “File_reader”

He creado un módulo para tal fin, con un único método que ejecuta todas las acciones para crear una variable de tipo array multidimensional que contenga todos los pares de valores del muestreo.
Cada acción debería haberse implementado en sus correspondientes métodos, siguiendo el principio de “single responsability”, pero como no era el propósito del ejercicio se optó por un simple método “read” que obtuviese los datos de una sola vez.

Lectura de datos - class “Arranger”

He creado una clase con un método de instancia “Init” que ejecuta todas las acciones.
Mi conjunto de datos es guardado en una variable de instancia @data_a.
Para poder buscar resultados necesito ordenar ese conjunto de datos en función de uno de los parámetros. En este caso se optó por ordenar la lista por altura.
Los métodos sort_by_heigth y sort_by_same_height ordenan primero en orden de altura ascendente y después considerando el caso en que valores consecutivos compartan peso.

Una vez tenemos la lista ordenada procedemos a recorrerla.
El método find_solution se encarga de recorrer cada uno de sus valores y buscar las combinaciones de valores consecutivos que tienen a su vez el mayor número de valores más altos que ellos mismos.

[[120, 50], [130, 100], [135, 60], [140, 60], [150, 70]] 

Si este fuera el caso, desde la primera posición y suponiendo ese valor como válido, se buscarán todos los pares consecutivos con un peso mayor de 50, lo que daría 

[130, 100], [135, 60], [140, 60], [150, 70].
						0 		1 		2 		3


Ahora hay que ver cada uno de ellos, cuantos valores mayores que si mismos tiene a continuación. Daría

[130, 100] --> 0 por encima
[135, 60] --> 2 por encima (ó igual peso), [140, 60], [150, 70]
[140, 60] --> 1 por encima [150, 70]
[150, 70] --> 0 por encima

Así compondríamos una matriz de resultados [0,2,1,0], quedándonos con el valor con mayor valor(2), que ocupa la posición 1 en la matriz de posibles valores,es decir [135, 60].
Añadimos esa combinación a una variable @each_match que usaremos para almacenar las mejores combinaciones de cada elemento de @data_a.
Si quedan elementos por recorrer en la en @data_a desde esa nueva posición, iniciamos recursivamente el proceso, hasta que lleguemos al final de las posibilidades(o bien las coincidencias de posibles valores mayores nos está  [] ó bien se ha llegado al final de @data_a y no quedan elementos por recorrerse) 
En ese momento se guarda el array de resultados en una variable que guardará todas las combinaciones para cada valor de la lista @final_result << @each_match .
El método que recorre todos los valores de nuestra lista de muestra es find_solution().
El método que busca las mejores soluciones es find_all(), que es el encargado de llamar a los métodos que realizan cada paso necesario:
ind_vals_above() / find_index_matches() / num_values_above()  / get_best_match()

El resultado final será de este tipo, donde cada fila representa las mejores combinaciones para cada elemento del muestreo.
[[[120, 70], [130, 100], [130, 101]],
 [[130, 100], [130, 101]],
 [[130, 101]],
 [[140, 60], [150, 70], [160, 80]],
 [[150, 50], [150, 70], [160, 80]],
 [[150, 70], [160, 80]],
 [[160, 80]]]
La parte final  show_best_solutions() se encargará de obtener los resultados de mayor tamaño y mostrarlos.
Algo como
[[120, 70], [130, 100], [130, 101]]
[[150, 50], [150, 70], [160, 80]]
[[140, 60], [150, 70], [160, 80]]
El flujo del proceso sería este:
￼
Notas

Aunque no es una buena práctica en este caso de cara a una mejor comprensión se han dejado comentados los diferentes métodos dentro de find_all() , ya que es donde se ejecuta en buena medida la lógica de la aplicación.

También, aunque en Ruby no hace falta poner return para devolver el último valor tocado, se ha añadido para facilitar una mejor revisión del ejercicio.

En una mejor implementación del ejercicio se buscarían también las soluciones para una lista ordenada por el peso. Se solucionaría ordenando al revés, usando variables de instancia con valores diferentes. En los métodos sort_by_heigth() / sort_by_same_height() habría que cambiar algunas cosas, para que lo que ahora son valores 0 / 1 vinieran dados según el caso.
sas

En el método get_best_match() considero solo el primer mejor resultado de los devueltos.
Si se quisieran dar todas las combinaciones posibles en ese punto habría que implementar alguna variante.

No se implementa una gran muestra para el fichero de datos data.txt, ya que creo que se usará otro por parte del examinador. Tan solo hay que cambiar el nombre del fichero con el que iniciativa la instancia de la clase Arranger.
-------------------
REFACTORIZACION
El ejercicio se ha refactorizado sacando a dos módulos independientes las funcionalidades de lectura de fichero y de ordenación de la lista.
También se han refactorizado varios métodos intentando que se cumpla el principio de responsabilidad única.
