# EDH Tracker

Stats de las partidas de Commander del grupo. Sin login: cualquiera con el link ve, agrega y edita.

## Puesta en marcha (una vez)

1. **Supabase**: crea un proyecto nuevo (gratis). En *SQL Editor* ejecuta `schema.sql` y después `seed.sql` (trae las 284 partidas de la planilla).
2. En *Project Settings → API* copia la **Project URL** y la **anon public key** y pégalas en `config.js`.
3. **GitHub**: sube esta carpeta a un repo público, ve a *Settings → Pages*, elige la rama `main` y la carpeta raíz. Queda en `https://<usuario>.github.io/<repo>/`.
4. Abre la página → pestaña **Datos** → "Detectar en todos los mazos" para marcar UB automáticamente. Revisa los que diga "no encontrados" (por ejemplo "Frodo / Sam": conviene escribir los nombres completos de las cartas).

## Seguridad sin login

- Borrar una partida la manda a la **papelera** (pestaña Datos), no se pierde.
- Cada edición de partidas y mazos queda copiada en `matches_history` / `decks_history`, visibles solo desde el panel de Supabase.
- La web no tiene permiso para borrar filas de verdad.
