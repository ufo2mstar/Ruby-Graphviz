# Copyright (C) 2004, 2005, 2006, 2007, 2008, 2009 Gregoire Lejeune <gregoire.lejeune@free.fr>
# 
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307  USA

class GraphViz
  class Attrs
    @data
    @name
    @attributs
	  @graphviz
    
    attr_accessor :data

    def initialize( gviz, name, attributs )
      @name      = name
      @attributs = attributs
      @data      = Hash::new( )
	    @graphviz  = gviz
    end

    def []( xKey )
      if @data.key?( xKey.to_s ) == false
        nil
      end
      @data[xKey.to_s]
    end

    def []=( xKey, xValue )
      unless @attributs.keys.include?( xKey.to_s )
        raise ArgumentError, "#{@name} attribut '#{xKey.to_s}' invalid"
      end
      
      value = ArgumentError
      @attributs[xKey.to_s].each do |type|
        begin
          value = GraphViz::Types.const_get(type).new( xValue )
          break
        rescue ArgumentError
          nil
        end
      end
      
      if value == ArgumentError
        raise ArgumentError, "Value `#{xValue}' not allowed for attribut #{xKey}, type #{@attributs[xKey.to_s].join(" or ")}!"
      end
      @data[xKey.to_s] = value

      if @graphviz.nil? == false
        @graphviz.set_position( @name, xKey.to_s, value )
      end
    end
  end
end
