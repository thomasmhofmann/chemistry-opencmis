/*
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements.  See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership.  The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License.  You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied.  See the License for the
 * specific language governing permissions and limitations
 * under the License.
 *
 * Authors:
 *     Florent Guillaume, Nuxeo
 */
/**
 * CMISQL tree grammar, walker for the inmemory implementation.
 * This aims at implementing proper semantics without any speed
 * optimization.
 */
tree grammar CmisQueryWalker;

options {
    tokenVocab = CMISQLParserStrict;
    ASTLabelType = CommonTree;
    output = AST;
}

@header {
/*
 * THIS FILE IS AUTO-GENERATED, DO NOT EDIT.
 *
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements.  See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership.  The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License.  You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied.  See the License for the
 * specific language governing permissions and limitations
 * under the License.
 *
 * Authors:
 *     Florent Guillaume, Nuxeo
 *
 * THIS FILE IS AUTO-GENERATED, DO NOT EDIT.
 */
package org.apache.chemistry.opencmis.inmemory.query;

import java.math.BigDecimal;

import java.util.Set;
import java.util.HashSet;
import java.util.Map;
import java.util.HashMap;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
}

@members {
    private static Log LOG = LogFactory.getLog(CmisQueryWalker.class);

    public QueryObject queryObj;
    public String errorMessage;

    @Override
    public void displayRecognitionError(String[] tokenNames,
            RecognitionException e) {
        if (errorMessage == null) {
            String hdr = getErrorHeader(e);
            String msg = getErrorMessage(e, tokenNames);
            errorMessage = hdr + " " + msg;
        }
    }
    
    public String getErrorMessageString() {
        return errorMessage;
    }
    
	protected void mismatch(IntStream input, int ttype, BitSet follow)
		throws RecognitionException
	{
		throw new MismatchedTokenException(ttype, input);
	}
	
	public void recoverFromMismatchedSet(IntStream input, RecognitionException e, antlr.collections.impl.BitSet follow)
		throws RecognitionException
	{
		throw e;
	}
}

// For CMIS SQL it will be sufficient to stop on first error:
@rulecatch {
	catch (RecognitionException e) {
		throw e;
	}
}

query [QueryObject qo]
	@init {
		queryObj = qo;
	}:
    ^(SELECT select_list from_clause order_by_clause? where_clause)
    {
    	queryObj.resolveTypes();
    	queryObj.processWhereClause($where_clause.tree);
    }
    ;

select_list:
      STAR
      {
      	  //queryObj.addSelectReference($STAR.getToken(), new ColumnReference($STAR.text));
      	  // LOG.debug("Adding * to col refs: " + $STAR);
      	  queryObj.addSelectReference($STAR, new ColumnReference($STAR.text));
      }
    | ^(SEL_LIST select_sublist+)
    ;

select_sublist
	scope { String current; }
	:
      value_expression column_name? 
      {
          // add selector
          queryObj.addSelectReference($value_expression.start, $value_expression.result);
          // add alias for column
          if ($column_name.text != null) {
             queryObj.addAlias($column_name.text, $value_expression.result);
          }
	  }
    | s=qualifier DOT STAR
      {
      	  // queryObj.addSelectReference($STAR.getToken(), new ColumnReference($qualifier.value, $STAR.text));
      	  //  LOG.debug("Adding x.* to col refs: " + $s.start);
      	  queryObj.addSelectReference($s.start, new ColumnReference($qualifier.value, $STAR.text));
      }
    ;
    
    
value_expression returns [CmisSelector result]:
      column_reference
      {
          $result = $column_reference.result;
      }
    | SCORE^
        {
            $result = new FunctionReference(FunctionReference.CmisQlFunction.SCORE);
        }
    ;

column_reference returns [ColumnReference result]:
    ^(COL qualifier? column_name)
      {
          $result = new ColumnReference($qualifier.value, $column_name.text);
      }
    ;

// multi_valued_column_reference returns [Object value]:
//    ^(COL qualifier? column_name)

qualifier returns [String value]:
      table_name
//    | correlation_name
    {
      $value = $table_name.text;
    }
    ;

from_clause:
    ^(FROM table_reference)
    ;

table_reference:
    one_table table_join*
    ;

table_join:
    ^(JOIN join_kind one_table join_specification?)
    {
      //throw new UnsupportedOperationException("JOIN");
    }
    ;

one_table:
    ^(TABLE table_name correlation_name?)
      {
          queryObj.addType($correlation_name.text, $table_name.text);
      }
    ;

join_kind:
    INNER | LEFT | OUTER;

join_specification:
    ^(ON cr1=column_reference EQ cr2=column_reference)
    {
          queryObj.addJoinReference($cr1.start, $cr1.result);
          queryObj.addJoinReference($cr2.start, $cr2.result);
    }
    ;

where_clause:
      ^(WHERE search_condition)
    | /* nothing */
    ;

search_condition
@init {
    List<Object> listLiterals;
}:
    ^(OR s1=search_condition s2=search_condition)
    | ^(AND s1=search_condition s2=search_condition)
    | ^(NOT search_condition)
    | ^(EQ search_condition search_condition)
    | ^(NEQ search_condition search_condition)
    | ^(LT search_condition search_condition)
    | ^(GT search_condition search_condition)
    | ^(GTEQ search_condition search_condition)
    | ^(LTEQ search_condition search_condition)
    | ^(LIKE search_condition search_condition)
    | ^(NOT_LIKE search_condition search_condition)
    | ^(IS_NULL search_condition) 
    | ^(IS_NOT_NULL search_condition) 
    | ^(EQ_ANY search_condition search_condition)
    | ^(IN_ANY search_condition in_value_list )
    | ^(NOT_IN_ANY search_condition in_value_list)
    | ^(CONTAINS qualifier? text_search_expression)
    | ^(IN_FOLDER qualifier? search_condition)
    | ^(IN_TREE qualifier? search_condition)
    | ^(IN column_reference in_value_list)
      {
           LOG.debug("IN list: " + $in_value_list.inList);
      }
    | ^(NOT_IN column_reference in_value_list)
    | value_expression
      {
          LOG.debug("  add node to where: " + $value_expression.start + " id: " + System.identityHashCode($value_expression.start));
          queryObj.addWhereReference($value_expression.start, $value_expression.result);      
      }
    | literal
    ;

in_value_list returns [Object inList]
@init {
    List<Object> inLiterals = new ArrayList<Object>();
}:
    ^(IN_LIST (l=literal {inLiterals.add($l.value);})+ )
    { 
    	$inList = inLiterals; 
    }
    ;

text_search_expression:
    STRING_LIT; // TODO: extend grammar with full text part


literal returns [Object value]:
      NUM_LIT
        {
            try {
                $value = Long.valueOf($NUM_LIT.text);
            } catch (NumberFormatException e) {
                $value = new BigDecimal($NUM_LIT.text);
            }
        }
    | STRING_LIT
        {
            String s = $STRING_LIT.text;
            $value = s.substring(1, s.length() - 1);
        }
    | TIME_LIT
        {
            String s = $TIME_LIT.text;
            s = s.substring(s.indexOf('\'') + 1, s.length() - 1);
            try {
                // $value = CalendarHelper.fromString(s);
            } catch (IllegalArgumentException e) {
                throw new UnwantedTokenException(Token.INVALID_TOKEN_TYPE, input);
            }
        }
    | BOOL_LIT
        {
            $value = Boolean.valueOf($BOOL_LIT.text);
        }
    ;

order_by_clause:
    ^(ORDER_BY sort_specification+)
    ;

sort_specification:
    column_reference ASC 
    {
       queryObj.addSortCriterium($column_reference.start, $column_reference.result, true);
    }
    | column_reference DESC 
    {
       queryObj.addSortCriterium($column_reference.start, $column_reference.result, false);
    }
    ;

correlation_name:
    ID;

table_name:
    ID;

column_name:
    ID;
