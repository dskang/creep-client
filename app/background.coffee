class Tracker
  @config:
    QUERY_INTERVAL: 3
    IDLE_THRESHOLD: 30

  @validateUrl: (url) ->
    /^http/.test url

  @queryBrowser: =>
    chrome.idle.queryState @config.IDLE_THRESHOLD, (state) =>
      if state == 'active'
        queryInfo =
          active: true
          lastFocusedWindow: true
        chrome.tabs.query queryInfo, (tabs) =>
          if tabs.length
            activeTab = tabs[0]
            if Tracker.validateUrl activeTab.url
              @updateServer activeTab.url

  @updateServer: (url) ->
    xhr = new XMLHttpRequest()
    xhr.open 'POST', 'http://creep.dskang.com/url'
    xhr.send
      url: url

window.setInterval Tracker.queryBrowser, Tracker.config.QUERY_INTERVAL * 1000
