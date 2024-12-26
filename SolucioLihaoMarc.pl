% Bibliografia:
% https://helloauto.com/es-es/glosario/


subsistema(cotxe, direccio).
subsistema(cotxe, transmissio).
subsistema(cotxe, encesa).
subsistema(cotxe, sistema_electric).
subsistema(cotxe, sistema_de_confort_interior).
subsistema(cotxe, motor).

% Avaries cotxes
avaria(direccio, manegues_desgastades).
avaria(direccio, baix_nivell_oli_direccio).
avaria(direccio, fallada_sistema_hidraulic).

avaria(transmissio, baix_nivell_flux).
avaria(transmissio, embragatge_desgastat).
avaria(transmissio, fallada_sistema_hidraulic).

avaria(encesa, bateria_defectuosa).
avaria(encesa, fallada_bobina_encendre).
avaria(encesa, fusibles_cremats).

avaria(sistema_electric, bateria_defectuosa).
avaria(sistema_electric, alternador_defectuos).
avaria(sistema_electric, fusibles_cremats).

avaria(sistema_de_confort_interior, fallada_motor_ventilador).
avaria(sistema_de_confort_interior, fuga_gas_refrigerant).
avaria(sistema_de_confort_interior, fallada_compressor).

avaria(motot)
% Possibles causes



% Dialeg amb l usuari
start :-
    write('Hola! Benvingut al programa de solucio de cotxes, refrigeradors i components de cuina'), nl,
    write("Quin es el teu nom?"), read(Nom)
    write("D'acord, ", Nom, ", quin es el teu problema?"), nl,
    write("Si us plau, escriu el problema en aquest format: 'observacio(Sistema, Subsistema, Avaria).'"), nl,
    write("Per exemple: observacio(cotxe, direccio, manegues_desgastades)."), read(Observacio)

% Funcio per detectar la causa de la avaria


