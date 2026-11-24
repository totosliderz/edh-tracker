# Historial de versiones del EDH Tracker

## v1.1 · 24/11/2026
- agregar partida: la ventana queda fija arriba y crece hacia abajo, los nombres ya no se mueven al tocarlos
- elegir mazo escribiendo: muestra los últimos 4 mazos del jugador y filtra solo los que empiezan con las letras que escribes
- duración opcional de la partida (hh:mm), visible en el historial y como promedio en el resumen
- título de la app y títulos principales con la fuente Beleren de Magic
- botón de modo claro / oscuro junto a la versión
- pestaña Ranking (antes Jugadores) y nueva pestaña Jugadores con los perfiles de cada uno
- se quita "powered by Claude" del banner

## v1.0 · 24/11/2026
- primera versión web del EDH Tracker: ranking de jugadores y mazos, historial, colores, retos y datos curiosos
- agregar partidas rápido: cada jugador ve solo sus mazos, "misma mesa que la última" y corona para el ganador
- base de datos compartida en Supabase, sin login, con papelera e historial de cambios
- mazos separados en commander + dueño, con detección automática de colores y Universes Beyond vía Scryfall
- 284 partidas importadas desde la planilla, con fechas invertidas y la partida #227 corregidas
- versión automática en cada commit, historial de versiones (CAMBIOS.md) y banner inferior con la versión
