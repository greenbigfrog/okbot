
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

coins = ["007", "1337", "1CR", "256", "2FLAV", "2GIVE", "404", "611", "888", "8BIT", "ACES", "ACLR", "ACOIN", "ACP", "ADC", "ADZ", "AEON", "AGRS", "AIB", "AIR", "ALC", "ALTC", "AM", "AMBER", "AMS", "ANI", "ANC", "ANTI", "APEX", "APC", "APT", "AR2", "ARB", "ARC", "ARCH", "ARM", "ABY", "ARTC", "ADCN", "AST", "ATEN", "ATM", "AUR", "AUD", "AV", "B3", "BAC", "BTA", "BAY", "BBCC", "BQC", "BEATS", "BEC", "BELA", "BERN", "BIGUP", "BILS", "BIOS", "BIT", "BIT16", "BITB", "BTC", "XBC", "BTCD", "BCY", "BFX", "BTM", "BITON", "BTQ", "BITS", "BSD", "BTS", "SWIFT", "BITZ", "BLK", "BLC", "BLEU", "BLITZ", "BLOCK", "BLRY", "BLU", "BM", "BNT", "BOB", "BOD", "BOLI", "BOMB", "BON", "BBR", "BOST", "BPOK", "BRAIN", "BRC", "BRDD", "BRIT", "GBP", "BRK", "BRX", "BSC", "BSH", "BST", "BTCHC", "BTD", "BTLC", "BTP", "BTZ", "BUB", "BUCKS", "BUN", "BURST", "BUZZ", "BVC", "BXT", "BYC", "BCN", "XCT", "C0C0", "CAB", "CAGE", "CAD", "CANN", "CCN", "CPC", "DIEM", "CASH", "CC", "CCX", "CDN", "CF", "CGA", "CKC", "CHEMX", "CHF", "CNY", "CHIP", "CJ", "CLAM", "CLINT", "CLOAK", "CLR", "CLUB", "CLUD", "CME", "CMT", "CNC", "COXST", "COIN", "C2", "CV2", "CON", "XCP", "COV", "COVAL", "COX", "CRAVE", "CRC", "CRE", "CRBIT", "CREVA", "CRNK", "CRPS", "CRT", "CRW", "CRX", "CRY", "CESC", "XCN", "CS", "CSMIC", "CTC", "CTO", "CURE", "CYC", "CYG", "CYP", "CZC", "CZECO", "CZR", "DAO", "DGD", "DNET", "DAS", "DASH", "DTC", "DBG", "DBTC", "DC", "DCC", "DCK", "DCT", "DCR", "DES", "DETH", "DEUR", "DEM", "DVC", "DGCS", "DGMS", "DMD", "DGB", "CUBE", "DGC", "XDN", "DP", "DIME", "DIRT", "DISK", "DLC", "DLISK", "NOTE", "DOGE", "DOPE", "DOX", "DRACO", "DROP", "DRZ", "DSH", "DTT", "DBIC", "DUO", "DXC", "EA", "EAC", "EBST", "ECC", "EDC", "EDR", "EDRC", "EGG", "EMC2", "EL", "ELCO", "ELE", "EFL", "EMB", "EME", "EMC", "EMIRG", "EMPC", "ENE", "ENRG", "EPC", "EPY", "ERC", "ERC3", "ESP", "ETH", "ETC", "EURC", "EUR", "EGC", "EVIL", "EVO", "EXCL", "EXP", "FCT", "FAIR", "FC2", "FCASH", "FCH", "FCN", "FTC", "TIPS", "FFC", "FIND", "FIT", "FJC", "FLO", "FLT", "FLX", "FLY", "FLDC", "FONZ", "FRK", "FRC", "FRN", "FRWC", "FSC2", "FSN", "FST", "FTP", "FUEL", "FUN", "FUTC", "FUZZ", "FX", "GAIA", "GAIN", "GAKH", "GAM", "GBT", "GAME", "GAP", "GARY", "GB", "GBC", "GBRC", "GCC", "GCN", "GEO", "GEMZ", "GHOST", "GHS", "GIFT", "GIZ", "BSTY", "GML", "GMX", "GOAT", "GCR", "GLD", "GOON", "GP", "GPU", "GRF", "GRAM", "GRT", "GRAV", "GRE", "GRC", "GRN", "GRS", "GRW", "GT", "GUA", "NLG", "GUM", "GUN", "HAM", "HAWK", "HBT", "HCC", "HEAT", "HMP", "XHI", "HIFUN", "HILL", "HNC", "HODL", "HKD", "HZ", "HTC", "HTML5", "HUC", "HVCO", "HYPER", "HYP", "I0C", "IBANK", "ICASH", "IMS", "IFC", "INFX", "INV", "IOC", "ION", "IRL", "ISL", "IVZ", "IXC", "JIF", "JIN", "JPC", "JPY", "JBS", "JWL", "KAT", "KC", "KGC", "KNC", "KLC", "KORE", "KRAK", "KRC", "KRYP", "KR", "L7S", "LANA", "LBC", "LC", "LEA", "LEAF", "LEMON", "LEO", "LFC", "LFO", "LFTC", "LIR", "LSK", "LTC", "LTCR", "LKC", "LOC", "LTBC", "LTD", "LTH", "LTS", "LUX", "LXC", "MAD", "XMG", "MAID", "MXT", "OMNI", "MTR", "MAX", "MZC", "MBL", "MCAR", "MCZ", "MED", "MEC", "MEME", "METAL", "MND", "MINT", "MM", "MMNXT", "MMXVI", "MNM", "MOIN", "MOJO", "MONA", "XMR", "MUE", "MOON", "MOTO", "MPRO", "MRB", "MRP", "MSC", "MST", "MUDRA", "MYC", "MYR", "N7", "NMC", "NAT", "NAUT", "NAV", "NCL", "NCS", "NDOGE", "NEBU", "XEM", "NEOS", "NET", "NEU", "NTRN", "NEVA", "NEWB", "NIRO", "NIC", "NICE", "NKC", "NKT", "NLC", "NOBL", "NODE", "NODES", "NVC", "NRS", "NTC", "NBT", "NUM", "NSR", "NXT", "NYC", "NZD", "OC", "OK", "OLYMP", "OMC", "OP", "OPAL", "OPES", "ORB", "ORLY", "OS76", "OTX", "P7C", "PAC", "PAK", "PAL", "PND", "PAPAF", "XPY", "PAYP", "PBC", "PDC", "PEC", "PPC", "PC", "PINKX", "PIO", "PIZZA", "PKB", "PLN", "PLNC", "PNK", "POKE", "PONZ2", "PONZI", "PEX", "POST", "POT", "PRES", "PXI", "PRIME", "XPM", "PRM", "PRT", "PSI", "PSP", "PTA", "PTC", "PULSE", "PURE", "PUTIN", "PWR", "PX", "QBC", "QBK", "QCN", "QORA", "QRK", "QTL", "RADI", "RADS", "RATIO", "RCN", "RED", "RDD", "REE", "REV", "RICHX", "RIC", "RBT", "RING", "XRP", "RISE", "RMS", "RONIN", "ROOT", "RPC", "RBIES", "RUBIT", "RUR", "RBY", "RUST", "SEC", "SANDG", "SAR", "SBD", "SCITW", "SCN", "SCOT", "SCRPT", "SCRT", "SCT", "SRC", "SXC", "SFE", "SFR", "SGD", "SH", "SDC", "SHELL", "SHF", "SHI", "SHIFT", "SHRM", "SC", "SIB", "SJW", "SKB", "SLING", "SLS", "SMBR", "SMC", "SMLY", "SNRG", "SOIL", "SLR", "SONG", "SOON", "SP", "SPEC", "SPEX", "SPHR", "SPM", "SPN", "SPORT", "SPR", "SPRTS", "SPT", "SQC", "SSC", "SSTC", "STAR", "START", "STE", "XST", "STEEM", "STR", "XLM", "STEPS", "SLG", "STL", "STO", "SJCX", "STRAT", "STRB", "STS", "STV", "UNITY", "SWING", "SDP", "SYNC", "AMP", "SYNX", "SYS", "TAB", "TAG", "TAGR", "TAJ", "TAM", "TAO", "TB", "TBC", "TBCX", "TCOIN", "TCR", "TDFB", "TDY", "TEK", "TELL", "TRC", "TES", "TET", "THC", "THS", "TIX", "XTC", "TIT", "TTC", "TMC", "TNG", "TODAY", "TOKEN", "TOOL", "TOT", "TP1", "TPC", "TRA", "TX", "TRAP", "TRICK", "TRIG", "TROLL", "TRON", "TRK", "TRUMP", "TRUST", "UAE", "UFO", "UIS", "UTC", "UNB", "UNC", "UNF", "UNIQ", "UNIT", "UNO", "URC", "URO", "USD", "USDE", "UTLE", "VAL", "XVC", "VCN", "VEC", "VENE", "XVG", "VRC", "VTC", "VIA", "VIOR", "VIP", "VIRAL", "VLT", "VOL", "VOOT", "VOX", "VPN", "VPRC", "VRM", "VTA", "VTN", "VTR", "VTY", "WAC", "WARP", "WAVES", "WAY", "WEX", "WGC", "XWC", "WBB", "WLC", "WMC", "LOG", "WDC", "X2", "XAB", "XAUR", "XBU", "XCO", "XC", "XDE", "XFC", "XFCX", "MI", "XID", "XJO", "XLTCG", "XMT", "XNG", "XNX", "XOC", "XPC", "XPOKE", "XPRO", "XQN", "XSEED", "XSP", "XTP", "YAC", "YAY", "YBC", "YMC", "YOC", "YOVI", "YUM", "ZCC", "ZEIT", "ZET2", "ZET", "ZRC", "ZNE", "ZNY", "ZS", "ZYD"]

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
    res["markets"].each { |x| string = string + "#{x["market"]}: #{x["price"]} BTC, " }
    client.create_message(message.channel_id, "#{string} _(Cryptonator)_")
  when /^\.market/
    # Gets maret info (price command + volume)
    response = get "https://api.cryptonator.com/api/full/ok-btc"
    res = response["ticker"]
    string = ""
    res["markets"].each { |x| string = string + "#{x["market"]}:\n  Price: #{x["price"]} BTC, Volume: #{x["volume"]} OK\n" }
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
