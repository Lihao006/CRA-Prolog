sistema(cotxe).
sistema(refrigerador).
sistema(cuina).

subsistema(cotxe, direccio).
subsistema(cotxe, transmissio).
subsistema(cotxe, encesa).
subsistema(cotxe, sistema_electric).
subsistema(cotxe, sistema_de_confort_interior).
subsistema(cotxe, motor).



% Avaries cotxes
avaria(direccio, [cotxe_fa_soroll], manegues_desgastades).
avaria(direccio, [cotxe_fa_soroll], baix_nivell_oli_direccio).
avaria(direccio, [cotxe_fa_soroll], allada_sistema_hidraulic).

avaria(transmissio, [cotxe_fa_soroll], baix_nivell_flux).
avaria(transmissio, [cotxe_fa_soroll], embragatge_desgastat).
avaria(transmissio, [cotxe_fa_soroll], fallada_sistema_hidraulic).

avaria(encesa, [cotxe_no_arranca], bateria_defectuosa).
avaria(encesa, [cotxe_no_arranca], fallada_bobina_encendre).
avaria(encesa, [cotxe_no_arranca], fusibles_cremats).

avaria(sistema_electric, [cotxe_no_arranca, fars_no_funcionen], bateria_defectuosa).
avaria(sistema_electric, [fars_no_funcionen], alternador_defectuos).
avaria(sistema_electric, [cotxe_no_arranca, fars_no_funcionen], fusibles_cremats).

avaria(sistema_de_confort_interior, [cotxe_no_enfria], fallada_motor_ventilador).
avaria(sistema_de_confort_interior, [cotxe_no_enfria], fuga_gas_refrigerant).
avaria(sistema_de_confort_interior, [cotxe_no_enfria], fallada_compressor).

avaria(motor, [cotxe_no_arranca], bugia_defectuosa).
avaria(motor, [cotxe_no_arranca], bomba_aigua_defectuosa).
avaria(motor, [cotxe_fa_soroll], carter_danyat).

avaria(fre, [no_frena], pastilles_desgastades).
avaria(fre, [no_frena], discos_desgastats).
avaria(fre, [no_frena], bomba_frens_defectuosa).
avaria(fre, [no_frena], problema_abs).

% Dialeg amb usuari
diagnostica :-
    write('Hola! Benvingut/da al programa de solucio de cotxes, refrigeradors i components de cuina'), nl,
    write("Si us plau, no escriguis accents ni caràcters especials, inlcoent majúscules, per evitar errors ;)"), nl,
    write("Quin es el teu nom?"), read(Nom)
    format("D'acord, , ~w, introdueix el sistema: cotxe, refrigerador o cuina.~n", [Nom]), read(Sistema),
    write("Introdueix el simptoma detectat (cotxe_no_arranca, cotxe_no_enfria, cotxe_fa_soroll, fars_no_funcionen, no_frena) o 'sortir' per acabar: "), nl,
    read(Simptoma),
    ( Simptoma == sortir ->
        write("Gracies per utilitzar el sistema. Adeu!"), nl;
      troba_causa(Simptoma),
      diagnostica
    ).

% Funcio per trobar totes les causes possibles del problema
troba_causa(Simptoma) :-
    findall((Subsistema, Causa), avaria(Subsistema, Simptomes, Causa), Causes),
    format("Les possibles causes son de ~w són:", [Simptoma]), nl,
    printllista(Causes).

% Funcio per convertir la llista Causes en un seguit de frases.
printllista([]).
printllista([(Subsistema, Causa)|Altres]) :-
    format("Subsistema: ~w, possible avaria: ~w~n", [Subsistema, Causa]),
    printllista(Altres).