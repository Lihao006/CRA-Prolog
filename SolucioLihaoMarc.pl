% Bibliografia:

% Avaries cotxes:
% https://helloauto.com/es-es/glosario/

% Raonament abductiu:
% https://book.simply-logical.space/src/text/3_part_iii/8.3.html

% Comandes de Prolog:
% https://es.scribd.com/document/373662386/Comandos-Prolog

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

avaria(motor, bugía_defectuosa).
avaria(motor, bomba_aigua_defectuosa).
avaria(motor, carter_danyat).

avaria(fre, pastilles_desgastades).
avaria(fre, discos_desgastats).
avaria(fre, bomba_frens_defectuosa).
avaria(fre, problema_abs).



% Possibles causes de avaries en cotxes
causa(cotxe_no_arranca, sistema_electric, bateria_defectuosa).
causa(cotxe_no_arranca, sistema_electric, fallada_bobina_encendre).
causa(cotxe_no_arranca, sistema_electric, fusibles_cremats).
causa(cotxe_no_arranca, motor, bugía_defectuosa).
causa(cotxe_no_arranca, motor, bomba_aigua_defectuosa).

causa(cotxe_no_enfria, sistema_de_confort_interior, fuga_gas_refrigerant).
causa(cotxe_no_enfria, sistema_de_confort_interior, fallada_compressor).
causa(cotxe_no_enfria, sistema_de_confort_interior, fallada_motor_ventilador).

causa(cotxe_fa_soroll, direccio, manegues_desgastades).
causa(cotxe_fa_soroll, direccio, baix_nivell_oli).
causa(cotxe_fa_soroll, direccio, fallada_sistema_hidraulic).
causa(cotxe_fa_soroll, transmissio, embragatge_desgastat).
causa(cotxe_fa_soroll, transmissio, baix_nivell_flux).
causa(cotxe_fa_soroll, transmissio, fallada_sistema_hidraulic).
causa(cotxe_fa_soroll, motor, carter_danyat).

causa(fars_no_funcionen, sistema_electric, fusibles_cremats).
causa(fars_no_funcionen, sistema_electric, bateria_defectuosa).
causa(fars_no_funcionen, sistema_electric, alternador_defectuos).

causa(no_frena, fre, pastilles_desgastades).
causa(no_frena, fre, discos_desgastats).
causa(no_frena, fre, bomba_frens_defectuosa).
causa(no_frena, fre, problema_abs).



% Convertir cadena de caràcters en llista per a les observacions
separar_cadena(Observacio, Llista) :-
    split_string(Observacio, "_", "", Llista).

% Funcio per detectar la causa de la avaria
detectar_causa(Resultats, Subsistema, Avaria) :-
    member(Subsistema, Resultats),
    causa(Observacio, Subsistema, Avaria).

% Dialeg amb usuari
start :-
    write('Hola! Benvingut/da al programa de solucio de cotxes, refrigeradors i components de cuina'), nl,
    write("Si us plau, no escriguis accents ni caràcters especials, inlcoent majúscules, per evitar errors ;)"), nl,
    write("Quin es el teu nom?"), read(Nom)
    format("D'acord, , ~w, introdueix el sistema: cotxe, refrigerador o cuina.~n", [Nom]), read(Sistema),
    write("Si us plau, introdueix la teva observació"), read(Observacio_del_usuari),
    % 
    separar_cadena('no_frena', Patrons),
    % Trobar paraules claus
    findall(Patro, (member(Patro, Patrons), sub_atom(Observacio_del_usuari, _, _, _, Patro)), Resultats),
    ( Resultats = [] -> write("Ho sento, però no puc ajudar-te amb aquesta observació.");
    format("S'han trobar les paraules claus següents: ~w", [Resultats]),
    format("Es refereix a ~w ?", [causa(Observacio, Subsistema, Avaria)]),
    format("Si us plau, escriu 'si' o 'no'"), read(Resposta),
    Resposta = 'si' -> format("La causa de l'avaria és ~w", [Avaria]);
    
      
      )

% Funcio per detectar la causa de la avaria


