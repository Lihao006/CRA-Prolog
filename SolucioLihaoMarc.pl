% Bibliografia:
% https://helloauto.com/es-es/glosario/




subsistema(cotxe, direccio).
subsistema(cotxe, transmissio).
subsistema(cotxe, encesa).
subsistema(cotxe, sistema_electric).
subsistema(cotxe, sistema_de_confort_interior).

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
