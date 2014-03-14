

clock_r=65
clock_x=500
clock_y=190
gauge_x1=250
gauge_x2=350
gauge_y1=190
gauge_y2=260

settings_table = {
    {
        name='time',
        arg='%I.%M',
        max=12,
        bg_colour=0xffffff,
        bg_alpha=0.1,
        fg_colour=0x0066FF,
        fg_alpha=0.2,
        x=clock_x, y=clock_y,
        radius=50,
        thickness=5,
        start_angle=0,
        end_angle=360
    },
    {
        name='time',
        arg='%M.%S',
        max=60,
        bg_colour=0xffffff,
        bg_alpha=0.1,
        fg_colour=0x0066FF,
        fg_alpha=0.4,
        x=clock_x, y=clock_y,
        radius=56,
        thickness=5,
        start_angle=0,
        end_angle=360
    },
    {
        name='time',
        arg='%S',
        max=60,
        bg_colour=0xffffff,
        bg_alpha=0.1,
        fg_colour=0x0066FF,
        fg_alpha=0.6,
        x=clock_x, y=clock_y,
        radius=62,
        thickness=5,
        start_angle=0,
        end_angle=-360
    },
    {
        name='time',
        arg='%d',
        max=31,
        bg_colour=0xffffff,
        bg_alpha=0.1,
        fg_colour=0x0066FF,
        fg_alpha=0.8,
        x=clock_x, y=clock_y,
        radius=70,
        thickness=5,
        start_angle=-90,
        end_angle=90
    },
    {
        name='time',
        arg='%m',
        max=12,
        bg_colour=0xffffff,
        bg_alpha=0.1,
        fg_colour=0x0066FF,
        fg_alpha=1,
        x=clock_x, y=clock_y,
        radius=76,
        thickness=5,
        start_angle=-90,
        end_angle=90
    },
    {
        name='cpu',
        arg='cpu1',
        max=100,
        bg_colour=0xEEEEEE,
        bg_alpha=0.8,
        fg_colour=0x0066FF,
        fg_alpha=0.8,
        x=gauge_x1, y=gauge_y1,
        radius=25,
        thickness=5,
        start_angle=-135,
        end_angle=135
    },
    {
        name='cpu',
        arg='cpu2',
        max=100,
        bg_colour=0xEEEEEE,
        bg_alpha=0.8,
        fg_colour=0x0066FF,
        fg_alpha=0.8,
        x=gauge_x2, y=gauge_y1,
        radius=25,
        thickness=5,
        start_angle=-135,
        end_angle=135
    },
    {
        name='cpu',
        arg='cpu3',
        max=100,
        bg_colour=0xEEEEEE,
        bg_alpha=0.8,
        fg_colour=0x0066FF,
        fg_alpha=0.8,
        x=gauge_x1, y=gauge_y2,
        radius=25,
        thickness=5,
        start_angle=-135,
        end_angle=135
    },
    {
        name='cpu',
        arg='cpu4',
        max=100,
        bg_colour=0xEEEEEE,
        bg_alpha=0.8,
        fg_colour=0x0066FF,
        fg_alpha=0.8,
        x=gauge_x2, y=gauge_y2,
        radius=25,
        thickness=5,
        start_angle=-135,
        end_angle=135
    },
    {
        name='memperc',
        arg='',
        max=100,
        bg_colour=0xEEEEEE,
        bg_alpha=0.8,
        fg_colour=0x0066FF,
        fg_alpha=0.8,
        x=644, y=gauge_y1,
        radius=25,
        thickness=5,
        start_angle=-135,
        end_angle=135
    },
    {
        name='swapperc',
        arg='',
        max=100,
        bg_colour=0xEEEEEE,
        bg_alpha=0.8,
        fg_colour=0x0066FF,
        fg_alpha=0.8,
        x=644, y=gauge_y2,
        radius=25,
        thickness=5,
        start_angle=-135,
        end_angle=135
    }
}


show_seconds=true

require 'cairo'

function rgb_to_r_g_b(colour,alpha)
    return ((colour / 0x10000) % 0x100) / 255., ((colour / 0x100) % 0x100) / 255., (colour % 0x100) / 255., alpha
end

function draw_ring(cr,t,pt)
    local w,h=conky_window.width,conky_window.height

    local xc,yc,ring_r,ring_w,sa,ea=pt['x'],pt['y'],pt['radius'],pt['thickness'],pt['start_angle'],pt['end_angle']
    local bgc, bga, fgc, fga=pt['bg_colour'], pt['bg_alpha'], pt['fg_colour'], pt['fg_alpha']

    local angle_0=sa*(2*math.pi/360)-math.pi/2
    local angle_f=ea*(2*math.pi/360)-math.pi/2
    local t_arc=t*(angle_f-angle_0)

    -- Draw background ring


    cairo_arc(cr,xc,yc,ring_r,angle_0,angle_f)
    cairo_set_source_rgba(cr,rgb_to_r_g_b(bgc,bga))
    cairo_set_line_width(cr,ring_w)
    cairo_stroke(cr)

    -- Draw indicator ring

    cairo_arc(cr,xc,yc,ring_r,angle_0,angle_0+t_arc)
    cairo_set_source_rgba(cr,rgb_to_r_g_b(fgc,fga))
    cairo_stroke(cr)
end

function draw_text(cr,t,pt)
    local xc,yc=pt['x'],pt['y']
    local fgc=pt['fg_colour']
    local te=cairo_text_extents_t:create()
    local text=string.format('%d%%',t)

    cairo_select_font_face (cr, "caviar dreams",
    CAIRO_FONT_SLANT_NORMAL, CAIRO_FONT_WEIGHT_BOLD);

    cairo_text_extents (cr, text, te);
    cairo_set_font_size (cr, 18);
    cairo_move_to (cr, xc - te.width / 2, yc + te.height / 2);
    cairo_show_text (cr, text);
    cairo_stroke(cr)
end

function draw_text_cpu(cr)
    local text='CPU'
    local te=cairo_text_extents_t:create()

    cairo_select_font_face (cr, "caviar dreams",
    CAIRO_FONT_SLANT_NORMAL, CAIRO_FONT_WEIGHT_BOLD);


    cairo_text_extents (cr, text, te);
    cairo_set_font_size (cr, 18);
    cairo_move_to (cr, (gauge_x1 + gauge_x2) / 2 - te.width / 2, (gauge_y1 + gauge_y2) / 2 + te.height / 2);
    cairo_show_text (cr, text);
    cairo_stroke(cr)
end
function draw_text_mem(cr)
    local text='MEM'
    local te=cairo_text_extents_t:create()

    cairo_select_font_face (cr, "caviar dreams",
    CAIRO_FONT_SLANT_NORMAL, CAIRO_FONT_WEIGHT_BOLD);


    cairo_text_extents (cr, text, te);
    cairo_set_font_size (cr, 18);
    cairo_move_to (cr, 644 - te.width / 2, (gauge_y1 - 40) + te.height / 2);
    cairo_show_text (cr, text);
    cairo_stroke(cr)
end
function draw_text_swap(cr)
    local text='SWAP'
    local te=cairo_text_extents_t:create()

    cairo_select_font_face (cr, "caviar dreams",
    CAIRO_FONT_SLANT_NORMAL, CAIRO_FONT_WEIGHT_BOLD);


    cairo_text_extents (cr, text, te);
    cairo_set_font_size (cr, 18);
    cairo_move_to (cr, 644 - te.width / 2, (gauge_y2 - 40) + te.height / 2);
    cairo_show_text (cr, text);
    cairo_stroke(cr)
end

function draw_clock_hands(cr,xc,yc)
    local secs,mins,hours,secs_arc,mins_arc,hours_arc
    local xh,yh,xm,ym,xs,ys

    secs=os.date("%S")
    mins=os.date("%M")
    hours=os.date("%I")

    secs_arc=(2*math.pi/60)*secs
    mins_arc=(2*math.pi/60)*mins+secs_arc/60
    hours_arc=(2*math.pi/12)*hours+mins_arc/12

    -- Draw hour hand

    xh=xc+0.7*clock_r*math.sin(hours_arc)
    yh=yc-0.7*clock_r*math.cos(hours_arc)
    cairo_move_to(cr,xc,yc)
    cairo_line_to(cr,xh,yh)

    cairo_set_line_cap(cr,CAIRO_LINE_CAP_ROUND)
    cairo_set_line_width(cr,5)
    cairo_set_source_rgba(cr,1.0,1.0,1.0,1.0)
    cairo_stroke(cr)

    -- Draw minute hand

    xm=xc+clock_r*math.sin(mins_arc)
    ym=yc-clock_r*math.cos(mins_arc)
    cairo_move_to(cr,xc,yc)
    cairo_line_to(cr,xm,ym)

    cairo_set_line_width(cr,3)
    cairo_stroke(cr)

    -- Draw seconds hand

    if show_seconds then
        xs=xc+clock_r*math.sin(secs_arc)
        ys=yc-clock_r*math.cos(secs_arc)
        cairo_move_to(cr,xc,yc)
        cairo_line_to(cr,xs,ys)

        cairo_set_line_width(cr,1)
        cairo_stroke(cr)
    end
end

function conky_clock_rings()
    local function setup_rings(cr,pt)
        local str=''
        local value=0

        str=string.format('${%s %s}',pt['name'],pt['arg'])
        str=conky_parse(str)

        value=tonumber(str)
        pct=value/pt['max']

        draw_ring(cr,pct,pt)

        if pt['max'] == 100 then
            draw_text(cr,pct*100,pt)
        end
    end

    -- Check that Conky has been running for at least 5s

    if conky_window==nil then return end
    local cs=cairo_xlib_surface_create(conky_window.display,conky_window.drawable,conky_window.visual, conky_window.width,conky_window.height)

    local cr=cairo_create(cs)

    local updates=conky_parse('${updates}')
    update_num=tonumber(updates)

    if update_num>5 then
        for i in pairs(settings_table) do
            setup_rings(cr,settings_table[i])
        end
    end

    draw_text_cpu(cr)
    draw_text_mem(cr)
    draw_text_swap(cr)
    draw_clock_hands(cr,clock_x,clock_y)
end
