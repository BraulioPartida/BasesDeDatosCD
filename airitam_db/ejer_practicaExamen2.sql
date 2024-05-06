/*Ejercicio 1: Se quiere dar seguimiento a los pasajeros cuyas maletas fueron extraviadas. En un
nuevo esquema llamado “reclamos” cree una tabla donde se incluya el id del pasajero, el id del
vuelo y el número de maletas extraviadas para este pasajero y vuelo en cuestión.*/

DROP SCHEMA IF EXISTS reclamos CASCADE;
CREATE SCHEMA IF NOT EXISTS reclamos;

CREATE TABLE IF NOT EXISTS reclamos.perdida_equipaje(
    id BIGSERIAL PRIMARY KEY,
    pasajero_id BIGINT NOT NULL,
    vuelo_id BIGINT NOT NULL,
    maletas_ext SMALLINT NOT NULL
);
/*Ejercicio 2: A la tabla anterior, agregue una restricción para que el número de maletas
extraviadas sea obligatoriamente 1 o más*/
ALTER TABLE reclamos.perdida_equipaje ADD CONSTRAINT equipaje_pos CHECK ( maletas_ext>0 );

/*Ejercicio 3: Agrega las restricciones de llaves foráneas adecuadas a la tabla del Ejercicio 2*/
ALTER TABLE reclamos.perdida_equipaje
    ADD FOREIGN KEY (pasajero_id) REFERENCES pasajero(id) ON DELETE CASCADE ON UPDATE RESTRICT,
    ADD FOREIGN KEY (vuelo_id) REFERENCES vuelo(id) ON DELETE CASCADE ON UPDATE RESTRICT;

/*Ejercicio 4: Favor de insertar a todos los pasajeros con maletas documentadas del vuelo con
id 5 (con sus respectivas maletas) a la tabla del Ejercicio 3*/
INSERT INTO reclamos.perdida_equipaje (pasajero_id, vuelo_id, maletas_ext)
    SELECT pasajero_vuelo.pasajero_id, pasajero_vuelo.vuelo_id, pasajero_vuelo.no_maletas
        FROM pasajero_vuelo
        WHERE no_maletas > 0 AND id = 5;

/*Ejercicio 5: Favor de actualizar la tabla de ciudad para que ahora la capital del país “Cyprus”
sea “Nicosia”. Puntos extra si te aseguras que suceda dentro de una transacción serializable*/
UPDATE ciudad
    SET es_capital = FALSE
    WHERE pais_id = (SELECT id FROM pais WHERE nombre = 'Cyprus')
    AND es_capital IS TRUE;


