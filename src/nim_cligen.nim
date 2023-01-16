import std/times
proc foo(i = 42, d = now()): void = echo d

when isMainModule:
  import cligen/argcvt, cligen
  proc argParse(dst: var DateTime, dfl: DateTime,
                a: var ArgcvtParams): bool =
    try: dst = times.parse(a.val, "yyyyMMdd")
    except TimeParseError:
      echo "bad DateTime: ", a.val; return false
    return true

  proc argHelp(dfl: DateTime, a: var ArgcvtParams): seq[string]=
    @[a.argKeys, "DateTime", getDateStr(dfl)]

  dispatch foo, help={"i": "favorite number", "d": "birthday"}
