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

avaria(encesa, [cotxe_no_arranca, no_es_mou], bateria_defectuosa).
avaria(encesa, [cotxe_no_arranca, no_es_mou], fallada_bobina_encendre).
avaria(encesa, [cotxe_no_arranca, no_es_mou], fusibles_cremats).

avaria(sistema_electric, [cotxe_no_arranca, no_es_mou, fars_no_funcionen], bateria_defectuosa).
avaria(sistema_electric, [fars_no_funcionen], alternador_defectuos).
avaria(sistema_electric, [cotxe_no_arranca, no_es_mou, fars_no_funcionen], fusibles_cremats).

avaria(sistema_de_confort_interior, [cotxe_no_enfria], fallada_motor_ventilador).
avaria(sistema_de_confort_interior, [cotxe_no_enfria], fuga_gas_refrigerant).
avaria(sistema_de_confort_interior, [cotxe_no_enfria], fallada_compressor).

avaria(motor, [cotxe_no_arranca, no_es_mou], bugia_defectuosa).
avaria(motor, [cotxe_no_arranca, no_es_mou], bomba_aigua_defectuosa).
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
      % Funciona te_aquest_simptoma(NouSimptoma) amb un sol arguement qaun en teoria necessita dos pq es una funcio parcial(pot esperar a q li donin el segon argument)
      % La funcio include afegeix el segon argument a te_aquest_simptoma automaticament, q son cada un dels elements de la llista Causes
      % Si retorna false és simplement que ha filtrat totes les causes i no queden cap :(
      include(te_aquest_simptoma(NouSimptoma), Causes, NovesCausesSegonsNouSimptoma),
      printllista(NovesCausesSegonsNouSimptoma),
      mes_obs(NovesCausesSegonsNouSimptoma, NovesCauses)
    ).

% Funció per buscar coincidencies entre el NouSimptoma i la llista Simptomes de cada avaria(...)
te_aquest_simptoma(NouSimptoma, (_, _, Simptomes)) :-
    member(NouSimptoma, Simptomes).

% Funció per trobar totes les causes possibles del problema
troba_causa(Simptoma, Causes) :-
    % Aqui es busca en totes les avaria(...) coincidencies amb el Simptoma en la llista de Simptomes, 
    % anotem les dades Subsistema i Causa de les avaria(...) coincidents i es guarden en la llista Causes.
    findall((Subsistema, Causa, Simptomes), (avaria(Subsistema, Simptomes, Causa), member(Simptoma, Simptomes)), Causes).

% Funció per convertir la llista Causes en un seguit de frases.
printllista([]).
printllista([(Subsistema, Causa, _)|Altres]) :-
    format("Subsistema: ~w, possible avaria: ~w~n", [Subsistema, Causa]),
    printllista(Altres).

% Funció per preguntar a usuari si les causes filtrades que queden son correctes
% Suposem que l usuari va a comprovar si els components dels subsistemes esmentades estan correctes o no
pregunta_usuari([]).
pregunta_usuari([(Subsistema, Causa, _)|Altres]) :-
    format("Comprova si hi ha ~w en el subsistema ~w? (si/no): ", [Causa, Subsistema]), nl,
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
  write("Introdueix el simptoma detectat (no_refreda, soroll_fort, baixa_eficiencia, fuites_de_gas, gel_al_evaporador, massa_fred, llum_no_funciona) o 'sortir' per diagnosticar un aparell diferent (encara que sigui el mateix sistema):"), nl,
  read(Simptoma),
  ( Simptoma == sortir -> 
      start;
    troba_causa(Simptoma, Causes),
    format("Les possibles causes de ~w son:~n", [Simptoma]),
    printllista(Causes),
    mes_obs(Causes, NovesCauses),
    pregunta_usuari(NovesCauses),
    diagnostica_refrigerador
  ).


% Part de diagnòstic de cotxes
diagnostica_cotxe :-
  write("Introdueix el simptoma detectat (cotxe_no_arranca, cotxe_no_enfria, no_es_mou, fars_no_funcionen, no_frena) o 'sortir' per diagnosticar un aparell diferent (encara que sigui el mateix sistema):"), nl,
  read(Simptoma),
  ( Simptoma == sortir ->
      start;
    troba_causa(Simptoma, Causes),
    format("Les possibles causes de ~w son:~n", [Simptoma]),
    printllista(Causes),
    mes_obs(Causes, NovesCauses),
    pregunta_usuari(NovesCauses),
    diagnostica_cotxe
  ).


% Part de diagnòstic de cuines
diagnostica_cuina :-
  write("Introdueix el simptoma detectat (fuites_gas, fuites_aigua, no_gas, calor, soroll_fort, no_ventila, no_hi_ha_aigua, no_encen_foc) o 'sortir' per diagnosticar un aparell diferent (encara que sigui el mateix sistema):"), nl,
  read(Simptoma),
  ( Simptoma == sortir ->
      start;
    troba_causa(Simptoma, Causes),
    format("Les possibles causes per a ~w son:~n", [Simptoma]),
    printllista(Causes),
    mes_obs(Causes, NovesCauses),
    pregunta_usuari(NovesCauses),
    diagnostica_cuina
  ).
