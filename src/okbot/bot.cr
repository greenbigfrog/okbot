
require "dotenv"
Dotenv.load(".env")

require "http/client"
require "json"

require "discordcr"

client = Discord::Client.new(token: ENV["TOKEN"], client_id: ENV["APPID"].to_u64)

def get(link : String)
  res = HTTP::Client.get link
  JSON.parse(res.body)
end

# RUBY code
# require 'restclient'
# require 'json'
# coins = []
# JSON.parse(RestClient.get("https://www.cryptonator.com/api/currencies"))["rows"].each {|x| coins << x["code"]}

# Beginning in cr
# JSON.parse(HTTP::Client.get("https://www.cryptonator.com/api/currencies").body)["rows"]#.each {|x| coins << x["code"]}

coins = ["007", "1337", "1CR", "256", "2FLAV", "2GIVE", "32BIT", "611", "888", "8BIT", "ACES", "ACLR", "ACOIN", "ACP", "ADC", "ADZ", "AECC", "AEON", "AGRS", "AIB", "AIR", "ALTC", "AMBER", "AMS", "AND", "ANI", "ANC", "ANS", "ANTI", "APEX", "APC", "APT", "AR2", "ARB", "ARC", "ARCH", "ARD", "ARDR", "ARM", "ABY", "ASAFE", "ADCN", "AST", "ATEN", "ATM", "ATOM", "ATX", "REP", "AUR", "AUD", "AV", "B3", "BAC", "BAN", "BTA", "BAY", "BBCC", "BQC", "BDC", "BEATS", "BEC", "BEEP", "BELA", "BERN", "BHC", "BIGUP", "BILL", "BILS", "BIOS", "BIT", "BITB", "BTC", "XBC", "BTCD", "BCY", "BFX", "BTM", "BITON", "BTQ", "BITS", "BSD", "BTS", "SWIFT", "BITZ", "BLK", "BLC", "BLEU", "BLITZ", "BLOCK", "BLRY", "BLU", "BM", "BNT", "BOLI", "BBR", "BOOM", "BOST", "BOSS", "BPOK", "BRAIN", "BRC", "BRDD", "BRE", "BRIT", "GBP", "BRK", "BRONZ", "BRX", "BS", "BSC", "BTCR", "BTCS", "BTD", "BTLC", "BTP", "BTTF", "BTX", "BTZ", "BUCKS", "BUN", "BURST", "BUZZ", "BVC", "BXT", "BYC", "BCN", "C0C0", "CAB", "CAGE", "CAID", "CALC", "CAD", "CANN", "CCN", "CPC", "DIEM", "CASH", "CBIT", "CC", "CCX", "CDN", "CF", "CGA", "CKC", "CHESS", "CHF", "CNY", "CHOOF", "CJ", "CLAM", "CLICK", "CLINT", "CLOAK", "CLR", "CLUB", "CLUD", "CLV", "CME", "CMT", "CNC", "COC", "COXST", "C2", "CV2", "CON", "XCP", "COVAL", "CRAB", "CRAFT", "CRAVE", "CRC", "CRE", "CRBIT", "CREVA", "CRIME", "CRNK", "CRPC", "CRPS", "CRT", "CRW", "CRX", "CRY", "CBX", "CESC", "XCN", "CS", "CSH", "CSMIC", "CTK", "CTO", "CURE", "CYG", "CYP", "CYT", "CZC", "CZR", "DAO", "DGD", "DNET", "DAS", "DASH", "DTC", "DB", "DBG", "DBTC", "DC", "DCC", "DCK", "DCRE", "DCT", "DCR", "DES", "DEUR", "DEM", "DVC", "DGCS", "DGMS", "DGORE", "DMD", "DGB", "CUBE", "DGC", "XDN", "DP", "DIME", "DISK", "DKC", "DLC", "DLISK", "DMC", "NOTE", "DOGE", "DOPE", "DOV", "DOX", "DPAY", "DRACO", "DRM8", "DROP", "DSH", "DBIC", "DUO", "DUST", "EAGS", "EAC", "EBST", "EC", "ECCHI", "ECC", "EDC", "EDR", "EDRC", "EGG", "EGO", "EMC2", "EL", "ELCO", "ELE", "EFL", "EMB", "EME", "EMC", "EMIRG", "ENRG", "ENT", "ENTER", "EQM", "EQUAL", "ERC", "ERC3", "ESC", "ETH", "ETC", "EUR", "EGC", "EVIL", "EVO", "EXCL", "EXP", "EXT", "FCT", "FAIR", "FC2", "FCH", "FCN", "FCP", "FTC", "TIPS", "FFC", "FIND", "FIRE", "FIT", "FJC", "FLO", "FLOZ", "FLT", "FLX", "FLY", "FLDC", "FONZ", "FOREX", "FRK", "FRDC", "FRC", "FRN", "FRWC", "FSN", "FST", "FTP", "FUEL", "FUN", "FUTC", "FUZZ", "FX", "GAIA", "GAIN", "GAKH", "GAM", "GBT", "GAME", "GAP", "GARY", "GB", "GBC", "GBIT", "GBRC", "GCC", "GCN", "GENE", "GEO", "GEMZ", "GHOST", "GHS", "GIFT", "GIG", "GIZ", "GLC", "BSTY", "GMCX", "GMX", "GNJ", "GOAT", "GCR", "GLD", "GOON", "GOTX", "GP", "GPU", "GRAM", "GRT", "GRE", "GRC", "GRN", "GRS", "GRW", "GSX", "GSY", "GT", "GUA", "NLG", "GUM", "GUN", "GYC", "HAM", "HAWK", "HBT", "HCC", "HEAT", "HEDG", "HEEL", "HMP", "XHI", "HILL", "HNC", "HODL", "HKD", "HZ", "HTC", "HTML5", "HUC", "HVCO", "HYPER", "HYP", "ICASH", "ICN", "IMPS", "IMS", "INCP", "IFC", "INFX", "INV", "IOC", "ION", "IRL", "ISL", "IVZ", "IXC", "JIF", "JIN", "JOBS", "JPC", "JPY", "JBS", "JW", "JWL", "KAT", "KC", "KGC", "KNC", "KLC", "KOBO", "KORE", "KRAK", "KRB", "KRC", "KRYP", "KR", "KTK", "L7S", "LANA", "LAZ", "LBC", "LC", "LEA", "LEO", "LFC", "LFO", "LFTC", "LGBTQ", "LIMX", "LIR", "LSK", "LTC", "LTCR", "LDOGE", "LKC", "LOC", "LOOT", "LTBC", "LTH", "LTS", "LUCKY", "LXC", "XMG", "MAID", "MAPC", "MXT", "OMNI", "MTR", "MAX", "MZC", "MBL", "MCAR", "MCZ", "MED", "MEC", "MEME", "METAL", "MG", "MND", "MINT", "MIS", "MM", "MMNXT", "MMXVI", "MNM", "MOIN", "MOJO", "MONA", "XMR", "MUE", "MOON", "MOTO", "MPRO", "MRB", "MRP", "MSC", "MST", "MUDRA", "MYR", "N2O", "N7", "NMC", "NAUT", "NAV", "NCL", "NCS", "NDOGE", "XEM", "NEOS", "NET", "NEU", "NTRN", "NEVA", "NEWB", "NXS", "NIC", "NKA", "NKC", "NLC", "NOBL", "NODES", "NVC", "NRS", "NTC", "NBT", "NSR", "NXT", "NXTTY", "NYC", "NZD", "OBS", "ODNT", "OK", "OLYMP", "OMC", "OP", "OPES", "ORB", "ORLY", "OS76", "OTX", "OZC", "P7C", "PAC", "PAL", "PND", "PARA", "PAY", "XPY", "PAYP", "PBC", "PCM", "PCS", "PDC", "PEC", "PPC", "PEN", "PHR", "PIN", "PC", "PINKX", "PIO", "PIZZA", "PKB", "PLN", "PLNC", "POKE", "PONZ2", "PONZI", "PEX", "POST", "POT", "POWER", "PRE", "PRES", "PXI", "PRIME", "XPM", "PRM", "PSB", "PSP", "PSY", "PTA", "PTC", "PULSE", "PURE", "PUTIN", "PWR", "PX", "PXL", "QBC", "QBK", "QCN", "QORA", "QRK", "QTL", "RAD", "RADI", "RADS", "XRA", "RBIT", "RCN", "RED", "RDD", "REE", "REV", "RICHX", "RIC", "RBT", "RING", "RIO", "XRP", "RISE", "RMS", "RONIN", "ROYAL", "RPC", "RRT", "RBIES", "RUBIT", "RUR", "RBY", "RYCN", "SEC", "SAR", "SBD", "SBIT", "SCAN", "SCB", "SCN", "SCOT", "SCRPT", "SCRT", "SCT", "SRC", "SED", "SXC", "SFE", "SGD", "SH", "SDC", "SHELL", "SHI", "SHIFT", "SHREK", "SC", "SIB", "SIGU", "SIX", "SJW", "SLFI", "SLING", "SLK", "SLS", "SMC", "SMLY", "SNGLS", "SNRG", "SOIL", "SLR", "SONG", "SOON", "SPACE", "SPEC", "SPEX", "SPHR", "SPKTR", "SPM", "SPN", "SPORT", "SPR", "SPT", "SPX", "STA", "STAR", "START", "STE", "XST", "STEEM", "XLM", "STR", "STEPS", "SLG", "STL", "STO", "SJCX", "STP", "STRAT", "STS", "STV", "SUB", "UNITY", "SWEET", "SWING", "SDP", "SYNC", "AMP", "SYNX", "SYS", "TAG", "TAGR", "TAJ", "TAK", "TALK", "TAO", "TBC", "TBCX", "TC", "TCOIN", "TDFB", "TDY", "TEAM", "TECH", "TEK", "TELL", "TRC", "TESLA", "TES", "TET", "THC", "TIA", "TIX", "XTC", "TIT", "TKN", "TMC", "TNG", "TODAY", "TOKEN", "TOOL", "TOT", "TP1", "TPC", "TRA", "TX", "TRAP", "TRICK", "TRIG", "TROLL", "TRK", "TRUMP", "TRUST", "TSC", "UAE", "UBIQ", "UFO", "UIS", "UAH", "UTC", "UNB", "UNC", "UNF", "UNIQ", "UNIT", "UNO", "URC", "URO", "USD", "USDE", "XVC", "VCN", "VCOIN", "VEC", "XVG", "VRC", "VTC", "VIA", "VIP", "VIRAL", "VLT", "VOOT", "VOX", "VOYA", "VPN", "VPRC", "VRM", "VTA", "VTR", "VTX", "VTY", "WA", "WAC", "WARP", "WASH", "WAVES", "WAY", "WEX", "WGC", "XWC", "WBB", "WINE", "WLC", "WMC", "LOG", "WDC", "X2", "XAB", "XAUR", "XAU", "XAV", "XBS", "XBU", "XCO", "XC", "XDB", "XDE", "XDE2", "XFC", "MI", "XID", "XJO", "XLTCG", "XMINE", "XNG", "XNX", "XOC", "XPC", "XPD", "XPO", "XPOKE", "XPRO", "XPTX", "XQN", "XSEED", "XSP", "XSSX", "XSY", "XTP", "XUP", "YAC", "YAY", "YBC", "YMC", "YOC", "YOVI", "YUM", "ZEC", "ZCC", "XZC", "ZCOIN", "ZEIT", "ZET2", "ZET", "ZRC", "ZIRK", "ZMC", "ZNE", "ZNY", "ZS", "ZUR", "ZYD"]

client.on_message_create do |message|
  case message.content
  when /^\.ping/
    # ATM just responds with "pong"
    client.create_message(message.channel_id, "pong")
  when /^\.invite/
    client.create_message(message.channel_id, "You can add your bot to your own server with the following URL:
https://discordapp.com/oauth2/authorize?&client_id=227838490174291968&scope=bot")
  when /^\.price/
    # Gets price info from cryptonator
    response = get "https://api.cryptonator.com/api/full/ok-btc"
    res = response["ticker"]
    string = ""
    res["markets"].each { |x| string = string + "#{x["market"]}: #{x["price"]} BTC, " unless x["market"] == "YoBit" }
    string = string.rchop ", "
    client.create_message(message.channel_id, "#{string} _(Cryptonator)_")
  when /^\.market/
    # Gets maret info (price command + volume)
    response = get "https://api.cryptonator.com/api/full/ok-btc"
    res = response["ticker"]
    string = ""
    res["markets"].each { |x| string = string + "#{x["market"]}:\n  Price: #{x["price"]} BTC, Volume: #{x["volume"]} OK\n" unless x["market"] == "YoBit" }
    client.create_message(message.channel_id, "```yaml\n#{string}(Cryptonator)\n```")
  when /^\.convert/
    # converts cryptocurrencies
    msg = message.content.split
    puts "msg: #{msg}"

    if msg.size < 4
      client.create_message(message.channel_id, "Usage: `.convert <amount> <base> <target>`, for example: `.convert 1000 ok usd`")
      next
    end

    begin
      amount = msg[1].to_f
    rescue
      client.create_message(message.channel_id, "Please supply a proper amount")
      next
    end

    base = msg[2].upcase
    target = msg[3].upcase
    unless coins.includes?(base)
      client.create_message(message.channel_id, "Unsupported base currency")
      next
    end
    unless coins.includes?(target)
      client.create_message(message.channel_id, "Unsupported target currency")
      next
    end

    response = get "https://api.cryptonator.com/api/full/#{base}-#{target}"
    conversionrate = response["ticker"]["price"].as_s.to_f

    price = conversionrate * amount

    client.create_message(message.channel_id, "**#{amount}** #{base} = **#{price}** #{target} (Cryptonator)")

  when /^\.bittrex/
    response = get "https://bittrex.com/api/v1.1/public/getticker?market=btc-ok"
    res = response["result"]
    bid = "%.8f" % res["Bid"].as_f
    ask = "%.8f" % res["Ask"].as_f
    last = "%.8f" % res["Last"].as_f
    client.create_message(message.channel_id, "**Bittrex**\n_Bid:_ #{bid}, _Ask:_ #{ask}, _Last_: #{last}")
  when /^\.cryptopia/
    response = JSON.parse(HTTP::Client.get("https://www.cryptopia.co.nz/api/GetMarket/1298", headers: HTTP::Headers{"Connection" => "Close"}).body)
    res = response["Data"]
    bid = "%.8f" % res["BidPrice"].as_f
    ask = "%.8f" % res["AskPrice"].as_f
    last = "%.8f" % res["LastPrice"].as_f
    client.create_message(message.channel_id, "**Cryptopia**\n_Bid:_ #{bid}, _Ask:_ #{ask}, _Last_: #{last}")
  when /^\.gif/
    msg = message.content.split
    tag = msg[1..-1].join("+")
    response = get "https://api.giphy.com/v1/gifs/random?api_key=dc6zaTOxFJmzC&tag=#{tag}"

    client.create_message(message.channel_id, "#{response["data"]["image_original_url"]}")

  when /^\.help/, /^.commands/
    client.create_message(message.channel_id, "List of commands: `.price`, `.market`, `.convert`, `.bittrex`, `.gif`")
  end
end

client.run
