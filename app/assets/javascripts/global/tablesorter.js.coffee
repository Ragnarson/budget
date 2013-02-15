jQuery ->
  $.tablesorter.addParser
    id: 'polish'
    type: 'text'
    is: (s) ->
      false
    format: (s) ->
      s
        .toLowerCase()
        .replace(/\u0105/g, 'az')
        .replace(/\u0119/g, 'ez')
        .replace(/\u0107/g, 'cz')
        .replace(/\u0144/g, 'nz')
        .replace(/ó/g, 'oz')
        .replace(/\u0142/g, 'lz')
        .replace(/\u015b/g, 'sz')
        .replace(/\u017a/g, 'zz')  #ź
        .replace(/\u017c/g, 'zzz') #ż

  lang = document.location.pathname.replace(/^\/([^\/]*).*$/, '$1')

  $.tablesorter.addParser
    id: 'amount'
    type: 'number'
    is: (s) ->
      false
    format: (s) ->
      if lang == "en"
        parseFloat s.replace(/,/g,'').replace("$",'')
      else if lang == "pl"
        parseFloat s.replace(',','.').replace(/\s/g,'')
      else
        s

  if $("#expenses_table").length
    $("#expenses_table").tablesorter
      headers:
        0:  sorter: 'polish'
        1:  sorter: 'amount'
        3:  sorter: false
