sistema(cotxe).
sistema(refrigerador).
sistema(cuina).


% Subsistemes de cotxe
subsistema(cotxe, cotxe_direccio).
subsistema(cotxe, cotxe_transmissio).
subsistema(cotxe, cotxe_encesa).
subsistema(cotxe, cotxe_electric).
subsistema(cotxe, cotxe_confort_interior).
subsistema(cotxe, cotxe_motor).

% Subsistemes de refrigerador
subsistema(refrigerador, refrigerador_refrigerant).
subsistema(refrigerador, refrigerador_electric).
subsistema(refrigerador, refrigerador_aillament).
subsistema(refrigerador, refrigerador_descongelacio).

% Subsistemes de cuina
subsistema(cuina, cuina_electric).
subsistema(cuina, cuina_gas).
subsistema(cuina, cuina_mecanic).


% Avaries cotxes
avaria(cotxe_direccio, [no_es_mou, vibracions], manegues_desgastades).
avaria(cotxe_direccio, [no_es_mou], baix_nivell_oli).
avaria(cotxe_direccio, [no_es_mou], fallada_sistema_hidraulic).
avaria(cotxe_direccio, [vibracions], pneumatic_punxat).

avaria(cotxe_transmissio, [no_es_mou], baix_nivell_liquid_refrigerant).
avaria(cotxe_transmissio, [no_es_mou], embragatge_desgastat).
avaria(cotxe_transmissio, [no_es_mou], fallada_sistema_hidraulic).
avaria(cotxe_transmissio, [vibracions], eixos_desgastats).
avaria(cotxe_transmissio, [vibracions], amortidors_desgastats).
avaria(cotxe_transmissio, [vibracions], caixa_canvis_defectuosa).

avaria(cotxe_encesa, [no_encen_motor, no_es_mou], bateria_descarregada).
avaria(cotxe_encesa, [no_encen_motor, no_es_mou], fallada_bobina_encendre).
avaria(cotxe_encesa, [no_encen_motor, no_es_mou], fusibles_cremats).
avaria(cotxe_encesa, [no_encen_motor, no_es_mou], falta_combustible).

avaria(cotxe_electric, [no_encen_motor, no_es_mou, fars_no_funcionen], bateria_descarregada).
avaria(cotxe_electric, [fars_no_funcionen], alternador_defectuos).
avaria(cotxe_electric, [no_encen_motor, no_es_mou, fars_no_funcionen], fusibles_cremats).

avaria(cotxe_confort_interior, [no_funciona_aire_acondicionat], fallada_motor_ventilador).
avaria(cotxe_confort_interior, [no_funciona_aire_acondicionat], fuga_gas_refrigerant).
avaria(cotxe_confort_interior, [no_funciona_aire_acondicionat], fallada_compressor).
avaria(cotxe_confort_interior, [no_funciona_aire_acondicionat], filtre_aire_defectuos).

avaria(cotxe_motor, [no_encen_motor, no_es_mou], bugia_defectuosa).
avaria(cotxe_motor, [no_encen_motor, no_es_mou], bomba_aigua_defectuosa).
avaria(cotxe_motor, [no_es_mou], carter_danyat).
avaria(cotxe_motor, [vibracions], filtres_motor_defectuosos).
avaria(cotxe_motor, [vibracions], baix_nivell_oli).

avaria(cotxe_fre, [no_frena, vibracions], pastilles_desgastades).
avaria(cotxe_fre, [no_frena, vibracions], discos_desgastats).
avaria(cotxe_fre, [no_frena], bomba_frens_defectuosa).
avaria(cotxe_fre, [no_frena], problema_abs).


% Avaries refrigeradors
avaria(refrigerador_refrigerant, [no_refreda, soroll_fort, fuita_gas], compressor_defectuos).
avaria(refrigerador_refrigerant, [no_refreda, fuita_gas, fuita_liquid], condensador_defectuos).
avaria(refrigerador_refrigerant, [no_refreda, fuita_gas, fuita_liquid], evaporador_defectuos).
avaria(refrigerador_refrigerant, [no_refreda], valvula_expansio_defectuos).

avaria(refrigerador_electric, [marca_malament_temperatura, no_encen_panell], panell_defectuos).
avaria(refrigerador_electric, [marca_malament_temperatura, no_refreda, refreda_massa], termostat_defectuos).
avaria(refrigerador_electric, [no_encen_llum], bombeta_fossa).
avaria(refrigerador_electric, [no_refreda], ventilador_defectuos).
avaria(refrigerador_electric, [no_refreda, no_encen_llum, no_encen_panell], falta_potencia_electrica).

avaria(refrigerador_aillament, [no_refreda], aillament_termic_defectuos).
avaria(refrigerador_aillament, [no_tanca_be], juntes_porta_defectuoses).

avaria(refrigerador_descongelacio, [acumulacio_gel], escalfador_defectuos).
avaria(refrigerador_descongelacio, [surt_aigua], drenatge_defectuos).



% Avaries cuines
avaria(cuina_electric, [acumulacio_fum], extractor_defectuos).
avaria(cuina_electric, [no_encen_panell_forn, forn_no_calenta], panell_forn_defectuos).
avaria(cuina_electric, [forn_no_calenta, salta_diferencial], resistencia_defectuos).
avaria(cuina_electric, [forn_no_calenta], falta_potencia_electrica).
avaria(cuina_electric, [forn_no_calenta, no_encen_panell_forn], font_alimentacio_defectuosa).

avaria(cuina_gas, [no_encenen_fogons, pudor_gas, escoltar_xiulet], fuita_gas).
avaria(cuina_gas, [no_encenen_fogons], falta_gas).
avaria(cuina_gas, [no_encenen_fogons, flama_dispersa], fogons_taponats).
avaria(cuina_gas, [flama_dispersa], xiclets_fogons_defectuosos).

avaria(cuina_mecanic, [no_encenen_fogons, no_regulen_fogons_be], panell_fogons_defectuos).




% Funcio per demanar mes observacions per reduir causes possibles
mes_obs(Causes, NovesCauses) :-
    write("Vols introduir mes observacions? (si/no)"), nl,
    read(Resposta1),
    ( Resposta1 == sortir ->
        start;
      Resposta1 == no -> 
        NovesCauses = Causes;
      Resposta1 == si -> 
        write("Si us plau, escriu el nou simptoma:"), nl,
        write("NO INTRODUEIXI EL MATEIX SIMPTOMA DE NOU."), nl,
        read(NouSimptoma),
        ( NouSimptoma == sortir ->
            start;

        % Utilitzem la funcio include que va incorporat en Prolog per filtrar la llista original de Causes en funcio del NouSimptoma introduit per lusuari.
        % Se li passa el patró te_aquest_simptoma(NouSimptoma), se li indica q ho ha de buscar en la llista Causes i es guarda en la nova llista NovesCausesSegonsNouSimptoma.
        % Funciona te_aquest_simptoma(NouSimptoma) amb un sol argument quan en teoria necessita dos pq es una funcio parcial(pot esperar a q li donin el segon argument)
        % La funcio include afegeix el segon argument a te_aquest_simptoma automaticament, q és cada un dels elements de la llista Causes
        % FInalment es crida recursivament per si lusuari vol seguir filtrant causes
        % Si retorna false és simplement que ha filtrat totes les causes i no queden cap :(
          
          include(te_aquest_simptoma(NouSimptoma), Causes, NovesCausesSegonsNouSimptoma),
          ( NovesCausesSegonsNouSimptoma == [] -> 
            (format("No s'ha trobat cap avaria amb aquest conjunt de simptomes.~n"), !);
          printllista(NovesCausesSegonsNouSimptoma),
          mes_obs(NovesCausesSegonsNouSimptoma, NovesCauses)
          )
        )
    ).

% Funció per buscar coincidencies entre el NouSimptoma i la llista Simptomes de cada avaria(...)
te_aquest_simptoma(NouSimptoma, (_, _, Simptomes)) :-
    member(NouSimptoma, Simptomes).

% Funció per trobar totes les causes possibles del problema
troba_causa(Sistema, Simptoma, Causes) :-
    % Aqui es busca en totes les avaria(...) coincidencies amb el Simptoma en la llista de Simptomes, 
    % anotem les dades Subsistema i Causa de les avaria(...) coincidents i es guarden en la llista Causes.
    findall((Subsistema, Causa, Simptomes), (avaria(Subsistema, Simptomes, Causa), member(Simptoma, Simptomes), subsistema(Sistema, Subsistema)), Causes).

% Funció per convertir la llista Causes en un seguit de frases.
printllista([], _).
printllista([(Subsistema, Causa, _)|Altres], Simptoma) :-
    format("Les possibles causes de ~w son:~n", [Simptoma]),
    format("Possible subsistema afectat: ~w, possible avaria: ~w~n", [Subsistema, Causa]),
    printllista(Altres, Simptoma).

% Funció per preguntar a usuari si les causes filtrades que queden son correctes
% Suposem que l usuari va a comprovar si els components dels subsistemes esmentades estan correctes o no
pregunta_usuari([]) :- format("No s'ha pogut trobar l'avaria.~n"), !.
pregunta_usuari([(Subsistema, Causa, _)|Altres]) :-
    format("Podries comprovar si hi ha ~w en el subsistema ~w? (si/no): ", [Causa, Subsistema]), nl,
    read(Resposta),
    ( Resposta == si ->
        format("La causa del problema es ~w en el subsistema ~w.~n", [Causa, Subsistema]);
      Resposta == no ->
        pregunta_usuari(Altres);
      Resposta == sortir ->
      start
    ).

% Dialeg amb usuari
% Introducció
start :-
    write('Hola! Benvingut/da al programa de solucio de cotxes, refrigeradors i components de cuina.'), nl,
    write("Si us plau, no escriguis accents ni caracters especials, inlcoent majuscules, per evitar errors ;). Recorda escriure un punt al final de cada comanda."), nl,
    write("Quin es el teu nom?"), nl,
    read(Nom),
    format("D'acord, ~w, introdueix el sistema que desitges reparar: cotxe, refrigerador o cuina.~n", [Nom]), 
    read(Sistema),
    (Sistema == cotxe -> diagnostica_cotxe;
    Sistema == refrigerador -> diagnostica_refrigerador;
    Sistema == cuina -> diagnostica_cuina;
    write("Aquest sistema encara no esta implementat. Torna-ho a provar."), nl,
    start
    ).


% Part de diagnòstic de refrigeradors
diagnostica_refrigerador :-
  write("Introdueix el simptoma detectat (no_refreda, soroll_fort, fuita_gas, fuita_liquid, marca_malament_temperatura, no_encen_panell, refreda_massa, no_encen_llum, no_tanca_be, acumulacio_gel, surt_aigua) o 'sortir' per diagnosticar un aparell diferent (encara que sigui el mateix sistema):"), nl,
  read(Simptoma),
  ( Simptoma == sortir -> 
      start;
    troba_causa(refrigerador, Simptoma, Causes),
    printllista(Causes, Simptoma),
    mes_obs(Causes, NovesCauses),
    pregunta_usuari(NovesCauses),
    !
  ).


% Part de diagnòstic de cotxes
diagnostica_cotxe :-
  write("Introdueix el simptoma detectat (no_encen_motor, no_funciona_aire_acondicionat, no_es_mou, vibracions, fars_no_funcionen, no_frena) o 'sortir' per diagnosticar un aparell diferent (encara que sigui el mateix sistema):"), nl,
  read(Simptoma),
  ( Simptoma == sortir ->
      start;
    troba_causa(cotxe, Simptoma, Causes),
    printllista(Causes, Simptoma),
    mes_obs(Causes, NovesCauses),
    pregunta_usuari(NovesCauses),
    !
  ).


% Part de diagnòstic de cuines
diagnostica_cuina :-
  write("Introdueix el simptoma detectat (acumulacio_fum, no_encen_panell_forn, forn_no_calenta, salta_diferencial, no_encenen_fogons, pudor_gas, escoltar_xiulet, flama_dispersa, no_regulen_fogons_be) o 'sortir' per diagnosticar un aparell diferent (encara que sigui el mateix sistema):"), nl,
  read(Simptoma),
  ( Simptoma == sortir ->
      start;
    troba_causa(cuina, Simptoma, Causes),
    printllista(Causes, Simptoma),
    mes_obs(Causes, NovesCauses),
    pregunta_usuari(NovesCauses),
    !
  ).
