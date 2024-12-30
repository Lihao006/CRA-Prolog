sistema(cotxe).
sistema(refrigerador).
sistema(cuina).


% Subsistemes de cotxe
subsistema(cotxe, direccio).
subsistema(cotxe, transmissio).
subsistema(cotxe, encesa).
subsistema(cotxe, electric).
subsistema(cotxe, confort_interior).
subsistema(cotxe, motor).
subsistema(cotxe, fre).

% Subsistemes de refrigerador
subsistema(refrigerador, refrigerant).
subsistema(refrigerador, electric).
subsistema(refrigerador, aillament).
subsistema(refrigerador, descongelacio).

% Subsistemes de cuina
subsistema(cuina, electric).
subsistema(cuina, gas).
subsistema(cuina, mecanic).


% Avaries cotxes
avaria(direccio, [no_es_mou, vibracions], manegues_desgastades).
avaria(direccio, [no_es_mou], baix_nivell_oli).
avaria(direccio, [no_es_mou], fallada_sistema_hidraulic).
avaria(direccio, [vibracions], pneumatic_punxat).

avaria(transmissio, [no_es_mou], baix_nivell_liquid_refrigerant).
avaria(transmissio, [no_es_mou], embragatge_desgastat).
avaria(transmissio, [no_es_mou], fallada_sistema_hidraulic).
avaria(transmissio, [vibracions], eixos_desgastats).
avaria(transmissio, [vibracions], amortidors_desgastats).
avaria(transmissio, [vibracions], caixa_canvis_defectuosa).

avaria(encesa, [no_encen_motor, no_es_mou], bateria_descarregada).
avaria(encesa, [no_encen_motor, no_es_mou], fallada_bobina_encendre).
avaria(encesa, [no_encen_motor, no_es_mou], fusibles_cremats).
avaria(encesa, [no_encen_motor, no_es_mou], falta_combustible).

avaria(electric, [no_encen_motor, no_es_mou, fars_no_funcionen], bateria_descarregada).
avaria(electric, [fars_no_funcionen], alternador_defectuos).
avaria(electric, [no_encen_motor, no_es_mou, fars_no_funcionen], fusibles_cremats).

avaria(confort_interior, [no_funciona_aire_acondicionat], fallada_motor_ventilador).
avaria(confort_interior, [no_funciona_aire_acondicionat], fuga_gas_refrigerant).
avaria(confort_interior, [no_funciona_aire_acondicionat], fallada_compressor).
avaria(confort_interior, [no_funciona_aire_acondicionat], filtre_aire_defectuos).

avaria(motor, [no_encen_motor, no_es_mou], bugia_defectuosa).
avaria(motor, [no_encen_motor, no_es_mou], bomba_aigua_defectuosa).
avaria(motor, [no_es_mou], carter_danyat).
avaria(motor, [vibracions], filtres_motor_defectuosos).
avaria(motor, [vibracions], baix_nivell_oli).

avaria(fre, [no_frena, vibracions], pastilles_desgastades).
avaria(fre, [no_frena, vibracions], discos_desgastats).
avaria(fre, [no_frena], bomba_frens_defectuosa).
avaria(fre, [no_frena], problema_abs).


% Avaries refrigeradors
avaria(refrigerant, [no_refreda, soroll_fort, fuita_gas], compressor_defectuos).
avaria(refrigerant, [no_refreda, fuita_gas, fuita_liquid], condensador_defectuos).
avaria(refrigerant, [no_refreda, fuita_gas, fuita_liquid], evaporador_defectuos).
avaria(refrigerant, [no_refreda], valvula_expansio_defectuos).

avaria(electric, [marca_malament_temperatura, no_encen_panell], panell_defectuos).
avaria(electric, [marca_malament_temperatura, no_refreda, refreda_massa], termostat_defectuos).
avaria(electric, [no_encen_llum], bombeta_fossa).
avaria(electric, [no_refreda], ventilador_defectuos).
avaria(electric, [no_refreda, no_encen_llum, no_encen_panell], falta_potencia_electrica).

avaria(aillament, [no_refreda], aillament_termic_defectuos).
avaria(aillament, [no_tanca_be], juntes_porta_defectuoses).

avaria(descongelacio, [acumulacio_gel], escalfador_defectuos).
avaria(descongelacio, [surt_aigua], drenatge_defectuos).



% Avaries cuines
avaria(electric, [acumulacio_fum], extractor_defectuos).
avaria(electric, [no_encen_panell_forn, forn_no_calenta], panell_forn_defectuos).
avaria(electric, [forn_no_calenta, salta_diferencial], resistencia_defectuos).
avaria(electric, [forn_no_calenta], falta_potencia_electrica).
avaria(electric, [forn_no_calenta, no_encen_panell_forn], font_alimentacio_defectuosa).

avaria(gas, [no_encenen_fogons, pudor_gas, escoltar_xiulet], fuita_gas).
avaria(gas, [no_encenen_fogons], falta_gas).
avaria(gas, [no_encenen_fogons, flama_dispersa], fogons_taponats).
avaria(gas, [flama_dispersa], xiclets_fogons_defectuosos).

avaria(mecanic, [no_encenen_fogons, no_regulen_fogons_be], panell_fogons_defectuos).




% Funcio per demanar mes observacions per reduir causes possibles
mes_obs(Causes, NovesCauses) :-
    write("Vols introduir mes observacions? (si/no)"), nl,
    read(Resposta1),
    ( Resposta1 == no -> 
        NovesCauses = Causes;
      Resposta1 == si -> 
      write("Si us plau, escriu el nou simptoma:"), nl,
      write("NO INTRODUEIXI EL MATEIX SIMPTOMA DE NOU."), nl,
      read(NouSimptoma),
      % Utilitzem la funcio include que va incorporat en Prolog per filtrar la llista original de Causes en funcio del NouSimptoma introduit per lusuari.
      % Se li passa el patró te_aquest_simptoma(NouSimptoma), se li indica q ho ha de buscar en la llista Causes i es guarda en la nova llista NovesCausesSegonsNouSimptoma.
      % Funciona te_aquest_simptoma(NouSimptoma) amb un sol arguement quan en teoria necessita dos pq es una funcio parcial(pot esperar a q li donin el segon argument)
      % La funcio include afegeix el segon argument a te_aquest_simptoma automaticament, q és cada un dels elements de la llista Causes
      % FInalment es crida recursivament per si lusuari vol seguir filtrant causes
      % Si retorna false és simplement que ha filtrat totes les causes i no queden cap :(
      include(te_aquest_simptoma(NouSimptoma), Causes, NovesCausesSegonsNouSimptoma),
      ( NovesCausesSegonsNouSimptoma == [] -> 
          format("Aixo no es possible.~n");
      printllista(NovesCausesSegonsNouSimptoma),
      mes_obs(NovesCausesSegonsNouSimptoma, NovesCauses)
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
printllista([]).
printllista([(Subsistema, Causa, _)|Altres]) :-
    format("Possible subsistema afectat: ~w, possible avaria: ~w~n", [Subsistema, Causa]),
    printllista(Altres).

% Funció per preguntar a usuari si les causes filtrades que queden son correctes
% Suposem que l usuari va a comprovar si els components dels subsistemes esmentades estan correctes o no
pregunta_usuari([]) :- format("No s'ha pogut trobar l'avaria.~n").
pregunta_usuari([(Subsistema, Causa, _)|Altres]) :-
    format("Podries comprovar si hi ha ~w en el subsistema ~w? (si/no): ", [Causa, Subsistema]), nl,
    read(Resposta),
    ( Resposta == si ->
        format("La causa del problema es ~w en el subsistema ~w.~n", [Causa, Subsistema]);
      Resposta == no ->
        pregunta_usuari(Altres)
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
    format("Les possibles causes de ~w son:~n", [Simptoma]),
    printllista(Causes),
    mes_obs(Causes, NovesCauses),
    pregunta_usuari(NovesCauses),
    diagnostica_refrigerador
  ).


% Part de diagnòstic de cotxes
diagnostica_cotxe :-
  write("Introdueix el simptoma detectat (no_encen_motor, no_funciona_aire_acondicionat, no_es_mou, vibracions, fars_no_funcionen, no_frena) o 'sortir' per diagnosticar un aparell diferent (encara que sigui el mateix sistema):"), nl,
  read(Simptoma),
  ( Simptoma == sortir ->
      start;
    troba_causa(cotxe, Simptoma, Causes),
    format("Les possibles causes de ~w son:~n", [Simptoma]),
    printllista(Causes),
    mes_obs(Causes, NovesCauses),
    pregunta_usuari(NovesCauses),
    diagnostica_cotxe
  ).


% Part de diagnòstic de cuines
diagnostica_cuina :-
  write("Introdueix el simptoma detectat (acumulacio_fum, no_encen_panell_forn, forn_no_calenta, salta_diferencial, no_encenen_fogons, pudor_gas, escoltar_xiulet, flama_dispersa, no_regulen_fogons_be) o 'sortir' per diagnosticar un aparell diferent (encara que sigui el mateix sistema):"), nl,
  read(Simptoma),
  ( Simptoma == sortir ->
      start;
    troba_causa(cuina, Simptoma, Causes),
    format("Les possibles causes per a ~w son:~n", [Simptoma]),
    printllista(Causes),
    mes_obs(Causes, NovesCauses),
    pregunta_usuari(NovesCauses),
    diagnostica_cuina
  ).
