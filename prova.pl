sistema(cotxe).
sistema(refrigerador).
sistema(cuina).

% Subsistemes de cotxe
subsistema(cotxe, direccio).
subsistema(cotxe, transmissio).
subsistema(cotxe, encesa).
subsistema(cotxe, sistema_electric).
subsistema(cotxe, sistema_de_confort_interior).
subsistema(cotxe, motor).

% Subsistemes de refrigerador
subsistema(refrigerador, refrigeracio).
subsistema(refrigerador, control_temperatura).
subsistema(refrigerador, circulacio_aire).
subsistema(refrigerador, desgel).
subsistema(refrigerador, iluminacio).

% Subsistemes de cuina
subsistema(cuina, control).
subsistema(cuina, ventilacio).
subsistema(cuina, aigua).
subsistema(cuina, gas).



% Avaries cotxes
avaria(direccio, [no_es_mou], manegues_desgastades).
avaria(direccio, [no_es_mou], baix_nivell_oli_direccio).
avaria(direccio, [no_es_mou], fallada_sistema_hidraulic).

avaria(transmissio, [no_es_mou], baix_nivell_flux).
avaria(transmissio, [no_es_mou], embragatge_desgastat).
avaria(transmissio, [no_es_mou], fallada_sistema_hidraulic).

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
avaria(motor, [no_es_mou], carter_danyat).

avaria(fre, [no_frena], pastilles_desgastades).
avaria(fre, [no_frena], discos_desgastats).
avaria(fre, [no_frena], bomba_frens_defectuosa).
avaria(fre, [no_frena], problema_abs).



% Avaries refrigeradors
avaria(refrigeracio, [no_refreda, soroll_fort, baixa_eficiencia], compressor_danyat).
avaria(refrigeracio, [fuites_de_gas, baixa_eficiencia, no_refreda], sistema_de_refrigerant_perdut).
avaria(refrigeracio, [gel_al_evaporador], sistema_de_desgel_danyat).

avaria(control_temperatura, [no_refreda, massa_fred], termostat_danyat).

avaria(circulacio_aire, [no_refreda, soroll_fort], ventilador_danyat).

avaria(desgel, [gel_al_evaporador], resistencia_desgel_danyada).

avaria(iluminacio, [llum_no_funciona], bombeta_fosa).



% Avaries cuines
avaria(control, [fuites_gas, fuites_aigua], fallada_valvula_seguretat).
avaria(control, [no_gas, no_encen_foc], fallada_encenedor).
avaria(control, [calor], termostat_danyat).

avaria(ventilacio, [soroll_fort, no_ventila], motor_campana_danyat).
avaria(ventilacio, [no_ventila], filtre_brut).

avaria(aigua, [no_hi_ha_aigua], aixeta_tancada).
avaria(aigua, [fuites_aigua, no_hi_ha_aigua], canonada_danyada).

avaria(gas, [fuites_gas], canonada_gas_danyada).
avaria(gas, [no_gas], regulador_gas_danyat).


% Dialeg amb usuari
% Introducció
start :-
    write('Hola! Benvingut/da al programa de solucio de cotxes, refrigeradors i components de cuina'), nl,
    write("Si us plau, no escriguis accents ni caràcters especials, inlcoent majúscules, per evitar errors ;)"), nl,
    write("Quin es el teu nom?"), 
    read(Nom),
    format("D'acord, , ~w, introdueix el sistema: cotxe, refrigerador o cuina.~n", [Nom]), 
    read(Sistema),
    (Sistema == cotxe -> diagnostica_cotxe;
    Sistema == refrigerador -> diagnostica_refrigerador;
    Sistema == cuina -> diagnostica_cuina;
    write("Aquest sistema encara no esta implementat. Torna-ho a provar."), nl,
    start
    ).

% Part de diagnostic de refrigeradors
diagnostica_refrigerador :-
    write("Introdueix el simptoma detectat (no_refreda, soroll_fort, baixa_eficiencia, fuites_de_gas, gel_al_evaporador, massa_fred, llum_no_funciona) o 'sortir' per tornar al principi: "), nl,
    read(Simptoma),
    ( Simptoma == sortir -> 
        start;
      troba_causa(Simptoma),
      diagnostica_refrigerador
    ).


% Part de diagnostic de cotxes
diagnostica_cotxe :-
    write("Introdueix el simptoma detectat (cotxe_no_arranca, cotxe_no_enfria, no_es_mou, fars_no_funcionen, no_frena) o 'sortir' per tornar al principi: "), nl,
    read(Simptoma),
    ( Simptoma == sortir ->
        start;
      troba_causa(Simptoma),
      diagnostica_cotxe
    ).


% Part de diagnostic de cuines
diagnostica_cuina :-
    write("Introdueix el simptoma detectat (fuites_gas, fuites_aigua, no_gas, calor, soroll_fort, no_ventila, no_hi_ha_aigua) o 'sortir' per tornar al principi: "), nl,
    read(Simptoma),
    ( Simptoma == sortir ->
        start;
      troba_causa(Simptoma),
      diagnostica_cuina
    ).



% Funcio per trobar totes les causes possibles del problema
troba_causa(Simptoma) :-
    % Aqui es busca en totes les avaria(...) coincidencies amb el Simptoma en la llista de Simptomes, 
    % anotem les dades Subsistema i Causa de les avaria(...) coindidents i es guarden en la llista Causes.
    findall((Subsistema, Causa), (avaria(Subsistema, Simptomes, Causa), member(Simptoma, Simptomes)), Causes),
    format("Les possibles causes son de ~w són:", [Simptoma]), nl,
    printllista(Causes).

% Funcio per convertir la llista Causes en un seguit de frases.
printllista([]).
printllista([(Subsistema, Causa)|Altres]) :-
    format("Subsistema: ~w, possible avaria: ~w~n", [Subsistema, Causa]),
    printllista(Altres).