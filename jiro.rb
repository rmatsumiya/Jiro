# -*- encoding:utf-8 -*-

def parse(str)
    mem = []
    pc = 0
    cmem = 0
    stack = []
    while pc < str.length do
        mem[cmem] ||= 0
        if str[pc...str.length] =~ /^ニンニク/
            cmem += 1
            pc += "ニンニク".length
        elsif str[pc...str.length] =~ /^ヤサイ/
            cmem -= 1
            pc += "ヤサイ".length
        elsif str[pc...str.length] =~ /^アブラ/
            print mem[cmem].chr Encoding::UTF_8
            pc += "アブラ".length
        elsif str[pc...str.length] =~ /^カラメ/
            mem[cmem] = gets.ord
            pc += "カラメ".length
        elsif str[pc...str.length] =~ /^マシ/
            mem[cmem] += 1
            pc += "マシ".length
        elsif str[pc...str.length] =~ /^少なめ/
            mem[cmem] -= 1
            pc += "少なめ".length
        elsif str[pc...str.length] =~ /^麺硬/
            if mem[cmem] == 0 then
                if str.index("麺柔", pc) == nil then
                    raise "Parse error"
                end
                pc = str.index("麺柔", pc) + "麺柔".length
            else
                stack.push pc
                pc += "麺硬".length
            end
        elsif str[pc...str.length] =~ /^麺柔/
            if stack.empty? then
                raise "Parse error"
            end
            pc = stack.pop
        else
            raise "Parse error"
        end
    end
    if !stack.empty? then
        raise "Parse error"
    end
end

parse(gets.chomp.encode("UTF-8"))
