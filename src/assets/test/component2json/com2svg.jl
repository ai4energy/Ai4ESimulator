function svg_define(component::Dict)
    return """<svg version="1.1" viewBox="0 0 $(component["width"]) $(component["height"])" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="$(component["width"])" height="$(component["height"])"> \n <rect width="$(component["width"])" height="$(component["height"])" stroke="black" stroke-width="$(component["stroke_width"])" fill = "white" fill-opacity="0"></rect>"""
end

function name_define(component::Dict)
    return """<text x="$(component["width"]/2)" y="$(component["height"]/2+5)" stroke="black" text-anchor="middle">$(component["name"])</text>"""
end

function port_define(component::Dict)
    Str = ""
    port_width = component["port_width"]
    port_size = component["port_size"]
    port = component["port"]
    for i in port
        num=length(i[2])
        if i[1]=="left_port"
            y_pos = collect(range(component["height"]/(num+1),step=component["height"]/(num+1),length=num))
            for (index,y) in enumerate(y_pos)
                i[2][index][2]=="in" ? Str *= """<polyline points= "0 $(y-port_size) $(port_size) $(y) 0 $(y+port_size)" stroke="black" stroke-width="$port_width" fill-opacity="0"></polyline>\n <text x="$(port_size+10)" y="$(y+5)" stroke="black" text-anchor="start">$(i[2][index][1])</text>\n""" : Str *= """<polyline points= "$(port_size) $(y-port_size) 0 $(y) $(port_size) $(y+port_size)" stroke="black" stroke-width="$port_width" fill-opacity="0"></polyline>\n <text x="$(port_size+10)" y="$(y+5)" stroke="black" text-anchor="start">$(i[2][index][1])</text>\n"""
            end
        elseif i[1]=="right_port"
            y_pos = collect(range(component["height"]/(num+1),step=component["height"]/(num+1),length=num))
            for (index,y) in enumerate(y_pos)
                i[2][index][2]=="out" ? Str *= """<polyline points= "$(component["width"]-port_size) $(y-port_size) $(component["width"]) $(y) $(component["width"]-port_size) $(y+port_size)" stroke="black" stroke-width="$port_width" fill-opacity="0"></polyline>\n <text x="$(component["width"]-port_size-10)" y="$(y+5)" stroke="black" text-anchor="end">$(i[2][index][1])</text>\n""" : Str *= """<polyline points= "$(component["width"]) $(y-port_size) $(component["width"]-port_size) $(y) $(component["width"]) $(y+port_size)" stroke="black" stroke-width="$port_width" fill-opacity="0"></polyline>\n <text x="$(component["width"]-port_size-10)" y="$(y+5)" stroke="black" text-anchor="end">$(i[2][index][1])</text>\n"""
            end
        elseif i[1]=="top_port"
            x_pos = collect(range(component["width"]/(num+1),step=component["width"]/(num+1),length=num))
            for (index,x) in enumerate(x_pos)
                i[2][index][2]=="in" ? Str *= """<polyline points= "$(x-port_size) 0 $(x) $(port_size) $(x+port_size) 0" stroke="black" stroke-width="$port_width" fill-opacity="0"></polyline>\n <text x="$(x)" y="$(port_size+20)" stroke="black" text-anchor="middle">$(i[2][index][1])</text>\n""" : Str *= """<polyline points= "$(x-port_size) $(port_size) $(x) 0 $(x+port_size) $(port_size)" stroke="black" stroke-width="$port_width" fill-opacity="0"></polyline>\n <text x="$(x)" y="$(port_size+20)" stroke="black" text-anchor="middle">$(i[2][index][1])</text>\n"""
            end
        elseif i[1]=="bottom_port"
            x_pos = collect(range(component["width"]/(num+1),step=component["width"]/(num+1),length=num))
            for (index,x) in enumerate(x_pos)
                i[2][index][2]=="out" ? Str *= """<polyline points= "$(x-port_size) $(component["height"]-port_size) $(x) $(component["height"]) $(x+port_size) $(component["height"]-port_size)" stroke="black" stroke-width="$port_width" fill-opacity="0"></polyline>\n <text x="$(x)" y="$(component["height"]-port_size-5)" stroke="black" text-anchor="middle">$(i[2][index][1])</text>\n""" : Str *= """<polyline points= "$(x-port_size) $(component["height"]) $(x) $(component["height"]-port_size) $(x+port_size) $(component["height"])" stroke="black" stroke-width="$port_width" fill-opacity="0"></polyline>\n <text x="$(x)" y="$(component["height"]-port_size-5)" stroke="black" text-anchor="middle">$(i[2][index][1])</text>\n"""
            end
        end
    end
    Str *= "</svg>"
    return Str
end

function generateSVG(component::Dict)
    Str=svg_define(component)*name_define(component)*port_define(component)
end
function generateSVG(filename::String,component::Dict)
    f = open("$(filename).svg", "w")
    s = generateSVG(component)
    write(f, s)
    close(f)
end

# generateSVG(component)
component = Dict(
    "name"=> "光伏组件",
    "height"=> 200.,
    "width"=> 200.,
    "stroke_width"=>5.,
    "port_size"=>15.,
    "port_width"=>3.,
    "port"=> [
        "left_port"=>[["p","in"]]
        "right_port"=>[["n","out"]]
        "top_port"=>[["u","in"]]
        "bottom_port"=>[]
      ])

generateSVG("test",component)
